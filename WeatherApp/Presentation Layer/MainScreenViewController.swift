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
    
    var data: [DailyForecastDataModel] = []
    
    private lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.register(CurrentWeatherHeader.self, forHeaderFooterViewReuseIdentifier: "Today Sector")
        table.register(TodayWeatherCell.self, forCellReuseIdentifier: "24 Hour Sector")
        table.register(DailyForecastMainScreenTableViewCell.self, forCellReuseIdentifier: "Daily Forecast Cell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DownloadManager().downloadWeather {
            print("Download is Complete")
            
            self.fetchResultController.delegate = self
            try? self.fetchResultController.performFetch()
            print("Fetch is Complete")
            self.data = self.fetchResultController.fetchedObjects!
            
            DispatchQueue.main.async {
                
                print("View Setup Started")
                self.view.backgroundColor = .white
                self.view.addSubview(self.tableView)
                self.navBarCustomization()
                self.setConstraints()
                print("View Setup Finished")
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
        self.navigationItem.title = "City, Country"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "LocationPoint"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "SettingsIcon"), style: .plain, target: self, action: nil)
    }
    
    
    func didTap24HourForecastButton () {
        let vc = WelcomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setConstraints() {
        tableView.edgesToSuperview()
    }
    
    
    //    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    //        tableView.reloadData()
    //    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CurrentWeatherHeader()
        view.delegate = self
        //            view.weatherForMainScreenHeader.date = weather.date ?? "error"
        //            view.weatherForMainScreenHeader.currentTemp = Int(weather.currentTemp)
        //            view.weatherForMainScreenHeader.weatherCondition = weather.weatherCondition ?? "error"
        //            view.weatherForMainScreenHeader.windSpeed = weather.windSpeed
        //            view.weatherForMainScreenHeader.humidity = Int(weather.humidity)
        //            view.weatherForMainScreenHeader.cloudiness = weather.cloudiness
        //            view.weatherForMainScreenHeader.sunsetTime = weather.sunsetTime ?? "error"
        //            view.weatherForMainScreenHeader.dawnTime = weather.dawnTime ?? "error"
        //            view.weatherForMainScreenHeader.lowestTemp = Int(weather.lowestTemp)
        //            view.weatherForMainScreenHeader.highestTemp = Int(weather.highestTemp)
        return view
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = TodayWeatherCell()
            cell.delegate = self
            
            return cell
        } else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "Daily Forecast Cell")!
            return cell
        }
    }
    
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    
}
