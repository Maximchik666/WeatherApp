//
//  WelcomeAgainViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 03.04.2023.
//

import Foundation
import UIKit
import TinyConstraints
import CoreData

class WelcomeAgainViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let fetchResultControllerForecasts: NSFetchedResultsController = {
        let fetchRequest = DailyForecastDataModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }()
    
    let fetchResultControllerInitialState: NSFetchedResultsController = {
        let fetchRequest = InitialStates.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "locationName", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        return frc
    }()
    
    
    var weatherData: [DailyForecastDataModel] = []
    var geolocationName: String = ""
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var welcomeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "WelcomeScreenImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var greetingTextField = CustomTextLabel(
        text: "Привет! Рады снова тебя видеть! Сейчас все настроим как было",
        textColor: .white, font: "Rubik-Medium", fontSize: 20)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager().getPermissions()
        setUpView()
        addingConstraints()
        activityIndicator.color = BundleColours.orange.color
        getData()
    }
    
    
    private func setUpView() {
        view.backgroundColor = UIColor(named: "DeepBlue")
        view.addSubview(welcomeImage)
        view.addSubview(greetingTextField)
        view.addSubview(activityIndicator)
     
    }
    
    private func addingConstraints () {
        
        welcomeImage.top(to: view, offset: 100)
        welcomeImage.centerX(to: view)
        welcomeImage.height(240)
        welcomeImage.width(310)
        
        greetingTextField.topToBottom(of: welcomeImage, offset: 60)
        greetingTextField.leading(to: view, offset: 30)
        greetingTextField.trailing(to: view, offset: -30)
        
        activityIndicator.topToBottom(of: greetingTextField, offset: 45)
        activityIndicator.centerX(to: view)
        activityIndicator.width(160)
        activityIndicator.height(160)
    }
    
    private func getData() {
             
        self.fetchResultControllerInitialState.delegate = self
        try? self.fetchResultControllerInitialState.performFetch()
        guard let initialData = self.fetchResultControllerInitialState.fetchedObjects!.first else {
            return
        }
        
        DownloadManager().downloadWeather(coordinates: (initialData.lattitude, initialData.longitude, (initialData.locationName ?? "error"))) { geolocationName in
            self.fetchResultControllerForecasts.delegate = self
            try? self.fetchResultControllerForecasts.performFetch()
            self.weatherData = self.fetchResultControllerForecasts.fetchedObjects!
            self.geolocationName = geolocationName
            
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                let vc = MainScreenViewController()
                vc.weatherData = self.weatherData
                self.activityIndicator.stopAnimating()
                vc.geolocationName = geolocationName
                vc.notificatonState = initialData.notificationIsOn
                vc.temperatureState = initialData.tempInFahreheit
                self.activityIndicator.stopAnimating()
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        
    }
    
}

