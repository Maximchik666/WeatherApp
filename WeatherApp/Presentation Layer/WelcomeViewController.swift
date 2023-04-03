//
//  WelcomeViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import Foundation
import UIKit
import TinyConstraints
import CoreData
import UserNotifications

final class WelcomeViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let fetchResultController: NSFetchedResultsController = {
        let fetchRequest = DailyForecastDataModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }()
    
    var weatherData: [DailyForecastDataModel] = []
    var geolocationName: String = ""
    var initialCoordinates: (Double,Double,String) = (0,0,"")
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var welcomeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "WelcomeScreenImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var upperTextField = CustomTextLabel(
        text: "Разрешить приложению Weather использовать данные о местоположении вашего устройства.",
        textColor: .white, font: "Rubik-Medium", fontSize: 20)
    
    private lazy var middleTextField = CustomTextLabel(
        text: "Чтобы получить более точные прогнозы погоды во время движения или путешествия.",
        textColor: .white, font: "Rubik-Regular", fontSize: 20)
    
    private lazy var bottomTextField: UILabel = CustomTextLabel(
        text: "Вы можете изменить свой выбор в любое время из меню приложения.",
        textColor: .white, font: "Rubik-Regular", fontSize: 20)
    
    
    private lazy var useGeolocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "Orange")!
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 13)
        button.addTarget(self, action: #selector(didTapAutoGeoButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var notUseGeolocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "DeepBlue")!
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Medium", size: 13)
        button.addTarget(self, action: #selector(didTapSelfGeoButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager().getPermissions()
        setUpView()
        addingConstraints()
        activityIndicator.color = BundleColours.orange.color
        
    }
    
    private func alert(title: String, message: String, okActionTitle: String) {
        
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let errorAlertView = UIAlertController(title: "Упс...", message: "Такого места я не знаю. Давай попробуем другое!", preferredStyle:.alert)
        
        let okAction = UIAlertAction(title: okActionTitle, style: .default) { _ in
            
            LocationManager().geocoder(querry: alertView.textFields![0].text!) { coord, error  in
                
                if let error = error {
                    print(error.localizedDescription)
                    self.present(errorAlertView, animated: true)
                    return
                }
                
                if let coord = coord {
                    
                    self.activityIndicator.startAnimating()
                    let vc = MainScreenViewController()
                    
                    DownloadManager().downloadWeather(coordinates: coord) { city in
                        
                        self.fetchResultController.delegate = self
                        try? self.fetchResultController.performFetch()
                        self.weatherData = self.fetchResultController.fetchedObjects!
                        self.geolocationName = city
                        self.initialCoordinates = coord
                        
                        DispatchQueue.main.async {
                            vc.weatherData = self.weatherData
                            self.activityIndicator.stopAnimating()
                            vc.geolocationName = self.geolocationName
                            self.navigationController?.pushViewController(vc, animated: false)
                            CoreDataManager.shared.clearInitialStatesDataBase()
                            CoreDataManager.shared.addInitialStates(longitude: self.initialCoordinates.1, lattitude: self.initialCoordinates.0, locationName: self.initialCoordinates.2, isFahrenheitOn: false, isNotificationsOn: false)
                        }
                    }
                }
            }
        }
        
        let tryAgainAction = UIAlertAction(title: "Давай попробуем!", style: .default) {_ in
            self.present(alertView,animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        alertView.addTextField()
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        errorAlertView.addAction(tryAgainAction)
        
        present(alertView,animated: true)
    }
    
    
    private func setUpView() {
        view.backgroundColor = UIColor(named: "DeepBlue")
        view.addSubview(welcomeImage)
        view.addSubview(upperTextField)
        view.addSubview(middleTextField)
        view.addSubview(bottomTextField)
        view.addSubview(useGeolocationButton)
        view.addSubview(notUseGeolocationButton)
        view.addSubview(activityIndicator)
    }
    
    private func addingConstraints () {
        
        welcomeImage.top(to: view, offset: 60)
        welcomeImage.centerX(to: view)
        welcomeImage.height(240)
        welcomeImage.width(310)
        
        upperTextField.topToBottom(of: welcomeImage, offset: 50)
        upperTextField.leading(to: view, offset: 30)
        upperTextField.trailing(to: view, offset: -30)
        
        middleTextField.topToBottom(of: upperTextField, offset: 20)
        middleTextField.leading(to: view, offset: 30)
        middleTextField.trailing(to: view, offset: -30)
        
        bottomTextField.topToBottom(of: middleTextField, offset: 20)
        bottomTextField.leading(to: view, offset: 30)
        bottomTextField.trailing(to: view, offset: -30)
        
        useGeolocationButton.topToBottom(of: bottomTextField, offset: 50)
        useGeolocationButton.leading(to: view, offset: 30)
        useGeolocationButton.trailing(to: view, offset: -30)
        useGeolocationButton.height(40)
        
        notUseGeolocationButton.topToBottom(of: useGeolocationButton, offset: 10)
        notUseGeolocationButton.leading(to: view, offset: 30)
        notUseGeolocationButton.trailing(to: view, offset: -30)
        notUseGeolocationButton.height(40)
        
        activityIndicator.topToSuperview(offset: 45)
        activityIndicator.leftToSuperview(offset: 30)
        activityIndicator.width(60)
        activityIndicator.height(60)
    }
    
    private func scheduleNotification() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Температура на сегодня"
        content.body = "Не забудьте проверить температуру на сегодня!"
        content.sound = UNNotificationSound.default
        
        // Отправляем уведомление каждый день в 9 утра
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        center.add(request)
    }
    
    @objc private func didTapAutoGeoButton() {
        
        self.activityIndicator.startAnimating()
        let locationManager = LocationManager()
        
        locationManager.findUserLocation { coord in
            
            let vc = MainScreenViewController()
            
            DownloadManager().downloadWeather(coordinates: coord) { city in
                
                self.fetchResultController.delegate = self
                try? self.fetchResultController.performFetch()
                self.weatherData = self.fetchResultController.fetchedObjects!
                self.geolocationName = city
                
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                    vc.weatherData = self.weatherData
                    self.activityIndicator.stopAnimating()
                    vc.geolocationName = city
                    self.activityIndicator.stopAnimating()
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
            CoreDataManager.shared.clearInitialStatesDataBase()
            CoreDataManager.shared.addInitialStates(longitude: self.initialCoordinates.1, lattitude: self.initialCoordinates.0, locationName: coord.2, isFahrenheitOn: false, isNotificationsOn: false)
        }
    }
    
    
    @objc private func didTapSelfGeoButton() {
        alert(title: "Приветствую!", message: "Введи пожалуйста населенный пункт, погоду в котором тебе хочется узнать", okActionTitle: "Ок")
    }
    
}
