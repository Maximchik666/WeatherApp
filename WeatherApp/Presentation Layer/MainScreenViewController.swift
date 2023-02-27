//
//  ViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.11.2022.
//

import UIKit

class MainScreenViewController: UIViewController {
    
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
        view.backgroundColor = .white
        view.addSubview(tableView)
        navBarCustomization()
        setConstraints()
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

}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CurrentWeatherHeader()
        return view
    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}
