//
//  DailyWeatherViewController.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 17.03.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class DailyWeatherViewController: UIViewController {
    
    var weatherData: [DailyForecastDataModel]!
    var selectedCell: Int = 0
    weak var delegate: MainScreenViewController!
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Default Cell")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButtonCustomization()
        
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
    
    private func backButtonCustomization() {
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

extension DailyWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = GeolocationNameTableViewCell()
            cell.geolocationLabel.text = delegate.geolocationName
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = DaySelectorTableViewCell()
            cell.delegate = self
            return cell
        } else {
            let cell = DailyWeatherTableViewCell()
            cell.weatherConditionLabel.text = weatherData[self.selectedCell].weatherCondition
            cell.tempLabel.text = String(String((Int((Double(weatherData[self.selectedCell].currentTemp) * delegate.tempMultiplicationCoef) + delegate.tempAdditionCoef)))) + "°"
            cell.cloudnessDataLabel.text = String(Int(weatherData[self.selectedCell].cloudiness*100)) + "%"
            cell.humidityDataLabel.text = String(weatherData[self.selectedCell].humidity) + "%"
            cell.conditionImage.image =  UIImage(named: weatherData[self.selectedCell].image ?? BundleImages.sun.rawValue)
            cell.sunriseDataLabel.text = weatherData[self.selectedCell].dawnTime
            cell.sunsetDataLabel.text = weatherData[self.selectedCell].sunsetTime
            cell.feelsLikeDataLabel.text = String(String((Int((Double(weatherData[self.selectedCell].feelsLike) * delegate.tempMultiplicationCoef) + delegate.tempAdditionCoef)))) + "°"
            cell.windSpeedDataLabel.text = String(weatherData[self.selectedCell].windSpeed) + " м/с"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1 {
            return 60
        }
        
        if indexPath.row == 2 {
            return 520
        } else {
            return 100
        }
    }
}
