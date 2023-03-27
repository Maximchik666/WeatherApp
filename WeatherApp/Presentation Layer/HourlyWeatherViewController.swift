//
//  HourlyWeatherViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class HourlyWeatherViewController: UIViewController {
    
    weak var delegate: MainScreenViewController!
    lazy var hourlyForecastData = getTimeSortedHourForecasts(from: delegate.weatherData, forHowMuchHours: 24)
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(HourlyForecastTableViewCell.self, forCellReuseIdentifier: "Hour Cell")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButtonCustomization()
        
        view.addSubview(tableView)
        tableView.edgesToSuperview()
        
    }
    
    func backButtonCustomization() {
        let backButton = UIButton()
        backButton.setTitle(" ← Вернуться назад", for: .normal)
        backButton.titleLabel?.font = UIFont(name: RubikFonts.light.rawValue, size: 15)
        backButton.setTitleColor(.gray, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension HourlyWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hourlyForecastData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = GeolocationNameTableViewCell()
            cell.geolocationLabel.text = delegate.geolocationName
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Hour Cell") as! HourlyForecastTableViewCell
            cell.cloudnessDataLabel.text = String(Int(hourlyForecastData[indexPath.row - 1].cloudness * 100)) + "%"
            cell.humidityDataLabel.text = String(hourlyForecastData[indexPath.row - 1].humidity) + "%"
            cell.windDataLabel.text = String(hourlyForecastData[indexPath.row - 1].windSpeed) + "м/с"
            cell.conditionLabel.text = "Состояние: " + (hourlyForecastData[indexPath.row - 1].condition ?? "Error")
            cell.conditionImage.image = UIImage(named: hourlyForecastData[indexPath.row - 1].image ?? BundleImages.sun.rawValue)
            cell.tempLabel.text = String(hourlyForecastData[indexPath.row - 1].temp) + "°"
            cell.hourLabel.text = hourlyForecastData[indexPath.row - 1].hour! + ":00"
            cell.dateLabel.text = hourlyForecastData[indexPath.row - 1].date
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else {
            return 165
        }
    }
}
