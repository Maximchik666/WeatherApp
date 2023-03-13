//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import UIKit
import CoreData

class MainScreenViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
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
    
    var initialCoordinates: (Double, Double)!
    
    private lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.register(CurrentWeatherHeader.self, forHeaderFooterViewReuseIdentifier: "Today Sector")
        table.register(TodayWeatherCell.self, forCellReuseIdentifier: "24 Hour Sector")
        table.register(DailyForecastMainScreenTableViewCell.self , forCellReuseIdentifier: "Daily Forecast Cell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        return table
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DownloadManager().downloadWeather(coordinates: initialCoordinates) {
            self.fetchResultController.delegate = self
            try? self.fetchResultController.performFetch()
            self.weatherData = self.fetchResultController.fetchedObjects!
            
            DispatchQueue.main.async {
                self.view.backgroundColor = .white
                self.view.addSubview(self.tableView)
                self.navBarCustomization()
                self.setConstraints()
            }
        }
    }
    
    private func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "\(weatherData[0].geolocation ?? "Error")"
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "LocationPoint"), style: .plain, target: self, action: #selector(getNewLocation))
        rightBarButtonItem.imageInsets = UIEdgeInsets(top: 2, left: 2, bottom: -2, right: -2)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "SettingsIcon"), style: .plain, target: self, action: nil)
        leftBarButtonItem.imageInsets = UIEdgeInsets(top: 5, left: 5, bottom: -5, right: -5)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    func didTap24HourForecastButton () {
        let vc = WelcomeViewController()
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
                
                self.initialCoordinates = coord ?? (0,0)
                
                DownloadManager().downloadWeather(coordinates: coord ?? (0,0)) {
             
                    try? self.fetchResultController.performFetch()
                    self.weatherData = self.fetchResultController.fetchedObjects!

                    DispatchQueue.main.async {
                        self.navigationItem.title = "\(self.weatherData[0].geolocation ?? "Error")"
                       // self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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
        return 8
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
                             highestTemp: Int(weatherData[0].highestTemp))
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = TodayWeatherCell()
            cell.delegate = self
            
            return cell
        } else {
            let cell =  DailyForecastMainScreenTableViewCell(
                style: UITableViewCell.CellStyle(rawValue: 0)!,
                reuseIdentifier: "Daily Forecast Cell",
                date: weatherData[indexPath.row - 1].date ?? "666",
                humidity: Int(weatherData[indexPath.row - 1].humidity),
                weatherCondition: weatherData[indexPath.row - 1].weatherCondition ?? "666",
                lowestTemp: Int(weatherData[indexPath.row - 1].lowestTemp),
                highestTemp: Int(weatherData[indexPath.row - 1].highestTemp))
            return cell
        }
    }
    
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    
}
