//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import UIKit
import CoreData

final class MainScreenViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
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
    var initialCoordinates: (Double, Double, String)!
    
    private lazy var tableView: UITableView = {
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DownloadManager().downloadWeather(coordinates: initialCoordinates) { city in
            self.fetchResultController.delegate = self
            try? self.fetchResultController.performFetch()
            self.weatherData = self.fetchResultController.fetchedObjects!
            self.geolocationName = city
            
            DispatchQueue.main.async {
                self.view.backgroundColor = .white
                self.view.addSubview(self.tableView)
                self.navBarCustomization(cityName: city)
                self.setConstraints()
            }
        }
    }
    
    private func navBarCustomization (cityName: String) {

        self.navigationItem.title = cityName
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "LocationPoint"), style: .plain, target: self, action: #selector(getNewLocation))
        rightBarButtonItem.tintColor = .black
        rightBarButtonItem.imageInsets = UIEdgeInsets(top: 2, left: 2, bottom: -2, right: -2)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "SettingsIcon"), style: .plain, target: self, action: nil)
        leftBarButtonItem.imageInsets = UIEdgeInsets(top: 5, left: 5, bottom: -5, right: -5)
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    func didTap24HourForecastButton () {
        let vc = DailyWeatherViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setConstraints() {
        tableView.edgesToSuperview()
    }
    
    func createAlertForNewLocation(title: String, message: String, okActionTitle: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default) { _ in
            CoreDataManager.shared.clearDataBase()
            LocationManager().geocoder(querry: alertView.textFields![0].text!) { coord in
                
                self.initialCoordinates = coord ?? (0,0, "Атлантида")
                
                DownloadManager().downloadWeather(coordinates: coord ?? (0,0, "Атлантида")) { city in
                    
                    try? self.fetchResultController.performFetch()
                    self.weatherData = self.fetchResultController.fetchedObjects!
                    self.geolocationName = city
                    
                    DispatchQueue.main.async {
                        self.navigationItem.title = city
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        alertView.addTextField()
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        
        present(alertView,animated: true)
    }
    
    @objc func getNewLocation() {
        createAlertForNewLocation(title: "Внимание!", message: "Введите название новой локации" , okActionTitle: "Принято")
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
                             currentTemp: Int(weatherData[0].currentTemp),
                             weatherCondition: weatherData[0].weatherCondition ?? "6666",
                             windSpeed: weatherData[0].windSpeed,
                             humidity: Int(weatherData[0].humidity),
                             cloudiness: weatherData[0].cloudiness,
                             sunsetTime: weatherData[0].sunsetTime ?? "6666666666666666",
                             dawnTime: weatherData[0].dawnTime ?? "6666666666",
                             lowestTemp: Int(weatherData[0].lowestTemp),
                             highestTemp: Int(weatherData[0].highestTemp),
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
                lowestTemp: Int(weatherData[indexPath.row - 3].lowestTemp),
                highestTemp: Int(weatherData[indexPath.row - 3].highestTemp),
                position: indexPath.row - 3,
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
    
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    
}
