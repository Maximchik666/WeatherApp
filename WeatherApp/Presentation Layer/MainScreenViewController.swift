//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import UIKit
import CoreData
import TinyConstraints

final class MainScreenViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var temperatureState = false
    var notificatonState = false
    var initialCoordinates: (Double,Double,String) = (0,0,"")
    
    var tempMultiplicationCoef: Double {
        return temperatureState ? 1.8 : 1
    }
    var tempAdditionCoef: Double {
        return temperatureState ? 32 : 0
    }
    
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
    
    lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(CurrentWeatherHeader.self, forHeaderFooterViewReuseIdentifier: "Today Sector")
        table.register(TodayWeatherCell.self, forCellReuseIdentifier: "24 Hour Sector")
        table.register(DailyForecastMainScreenTableViewCell.self , forCellReuseIdentifier: "Daily Forecast Cell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        table.register(TwentyFourHourButtonCell.self, forCellReuseIdentifier: "24 Hour Info Cell")
        table.register(SevenDaysForecast.self, forCellReuseIdentifier: "7 Days info Cell")
        table.separatorStyle = .none
        return table
    }()
    
    let menuContainer = UIView()
    var menuLeadingConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "DeepBlue")
        view.addSubview(self.tableView)
        navBarCustomization(cityName: geolocationName)
        setConstraints()
        scheduleNotification()
    }
    
    private func navBarCustomization (cityName: String) {
        
        self.navigationItem.title = cityName
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "LocationPoint"), style: .plain, target: self, action: #selector(getNewLocation))
        rightBarButtonItem.tintColor = .black
        rightBarButtonItem.imageInsets = UIEdgeInsets(top: 2, left: 2, bottom: -2, right: -2)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "SettingsIcon"), style: .plain, target: self, action: #selector(showSettings))
        leftBarButtonItem.imageInsets = UIEdgeInsets(top: 5, left: 5, bottom: -5, right: -5)
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    func didTap7DayForecastButton () {
        let vc = DailyWeatherViewController()
        vc.weatherData = weatherData
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTap24HoursButton () {
        let vc = HourlyWeatherViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setConstraints() {
        tableView.edgesToSuperview()
    }
    
    func createAlertForNewLocation(title: String, message: String, okActionTitle: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let errorAlertView = UIAlertController(title: "Упс...", message: "Такого места я не знаю. Давай попробуем другое!", preferredStyle:.alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default) { _ in
            
            LocationManager().geocoder(querry: alertView.textFields![0].text!) { coord, error  in
                
                if let error = error{
                    print(error.localizedDescription)
                    self.present(errorAlertView, animated: true)
                    return
                }
                
                CoreDataManager.shared.clearForecastDataBase()
                DownloadManager().downloadWeather(coordinates: coord ?? (0,0, "Атлантида")) { city in
                    
                    try? self.fetchResultController.performFetch()
                    self.weatherData = self.fetchResultController.fetchedObjects!
                    self.geolocationName = city
                    self.initialCoordinates = coord ?? (0,0, "Атлантида")
                    
                    DispatchQueue.main.async {
                        self.navigationItem.title = city
                        self.tableView.reloadData()
                        CoreDataManager.shared.clearInitialStatesDataBase()
                        CoreDataManager.shared.addInitialStates(longitude: self.initialCoordinates.1, lattitude: self.initialCoordinates.0, locationName: city, isFahrenheitOn: self.temperatureState, isNotificationsOn: self.notificatonState)
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        let tryAgainAction = UIAlertAction(title: "Давай попробуем!", style: .default) {_ in
            self.present(alertView, animated: true)
        }
        
        alertView.addTextField()
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        errorAlertView.addAction(tryAgainAction)
        present(alertView, animated: true)
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
        
        if notificatonState {
            let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
            center.add(request)
        }
    }
    
    
    
    @objc func getNewLocation() {
        createAlertForNewLocation(title: "Внимание!", message: "Введите название новой локации" , okActionTitle: "Принято")
    }
    
    @objc func showSettings() {
        let vc = SetupViewController()
        vc.delegate = self
        vc.temperatureSwitch.isSelected = temperatureState
        vc.notificationSwitch.isSelected = notificatonState
        navigationController?.present(vc, animated: true)
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        CurrentWeatherHeader(reuseIdentifier: "Header",
                             date: weatherData[0].date ?? "666666666",
                             currentTemp: Int((Double(weatherData[0].currentTemp) * tempMultiplicationCoef) + tempAdditionCoef),
                             weatherCondition: weatherData[0].weatherCondition ?? "6666",
                             windSpeed: weatherData[0].windSpeed,
                             humidity: Int(weatherData[0].humidity),
                             cloudiness: weatherData[0].cloudiness * 100,
                             sunsetTime: weatherData[0].sunsetTime ?? "6666666666666666",
                             dawnTime: weatherData[0].dawnTime ?? "6666666666",
                             lowestTemp: Int((Double(weatherData[0].lowestTemp) * tempMultiplicationCoef) + tempAdditionCoef),
                             highestTemp: Int((Double(weatherData[0].highestTemp) * tempMultiplicationCoef) + tempAdditionCoef),
                             feelsLike: Int(weatherData[0].feelsLike))
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = TwentyFourHourButtonCell()
            cell.delegate = self
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = TodayWeatherCell()
            cell.delegate = self
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = SevenDaysForecast()
            cell.delegate = self
            return cell
        } else {
            let cell =  DailyForecastMainScreenTableViewCell(
                style: UITableViewCell.CellStyle(rawValue: 0)!,
                reuseIdentifier: "Daily Forecast Cell",
                date: weatherData[indexPath.row - 3].date ?? "666",
                humidity: Int(weatherData[indexPath.row - 3].humidity),
                weatherCondition: weatherData[indexPath.row - 3].weatherCondition ?? "666",
                lowestTemp: Int((Double(weatherData[indexPath.row - 3].lowestTemp) * tempMultiplicationCoef) + tempAdditionCoef),
                highestTemp: Int((Double(weatherData[indexPath.row - 3].highestTemp) * tempMultiplicationCoef) + tempAdditionCoef),
                image: weatherData[indexPath.row - 3].image ?? "666")
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        
        if indexPath.row == 1 {
            return 80
        }
        
        if indexPath.row == 2 {
            return 40
        } else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

