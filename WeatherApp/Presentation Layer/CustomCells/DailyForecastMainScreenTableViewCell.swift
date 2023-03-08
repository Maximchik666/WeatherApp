//
//  DailyForecastMainScreenTableCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import UIKit
import TinyConstraints

class DailyForecastMainScreenTableViewCell: UITableViewCell {
    
    var dataForDailyWeatherCell = DailyForecastViewModel(id: "", highestTemp: 0, lowestTemp: 0, currentTemp: 0, weatherCondition: "", date: "", windSpeed: 0, dawnTime: "", sunsetTime: "", cloudiness: 0, humidity: 0, hourlyForecast: [])
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.text = self.dataForDailyWeatherCell.date
        label.font = UIFont(name: "Rubik-Medium", size: 10.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var humidityIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RainPossibilityIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "\(dataForDailyWeatherCell.humidity) %"
        label.font = UIFont(name: "Rubik-Regular", size: 15.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentWeatherConditionLabel: UILabel = {
        let label = UILabel()
        label.text = dataForDailyWeatherCell.weatherCondition
        label.font = UIFont(name: "Rubik-Regular", size: 17.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = String(dataForDailyWeatherCell.lowestTemp) + "° / " + String(dataForDailyWeatherCell.highestTemp) + "°"
        label.font = UIFont(name: "Rubik-Regular", size: 17.0)
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeMoreDetailLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.font = UIFont(name: "Rubik-Regular", size: 27.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, date: String, humidity: Int, weatherCondition: String, lowestTemp: Int, highestTemp: Int) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        dataForDailyWeatherCell.date = date
        dataForDailyWeatherCell.humidity = humidity
        dataForDailyWeatherCell.weatherCondition = weatherCondition
        dataForDailyWeatherCell.lowestTemp = lowestTemp
        dataForDailyWeatherCell.highestTemp = highestTemp
        
        addingSubviews()
        addingConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func addingSubviews(){
        addSubview(dateLabel)
        addSubview(humidityLabel)
        addSubview(humidityIcon)
        addSubview(currentWeatherConditionLabel)
        addSubview(temperatureLabel)
        addSubview(seeMoreDetailLabel)
    }
    
    private func addingConstraints() {
        
        contentView.height(80)
         
        dateLabel.leading(to: contentView, offset: 30)
        dateLabel.top(to: contentView, offset: 20)
        
        humidityIcon.topToBottom(of: dateLabel, offset: 20)
        humidityIcon.leading(to: contentView, offset: 30)
        humidityIcon.height(20)
        humidityIcon.width(30)
        
        humidityLabel.leadingToTrailing(of: humidityIcon, offset: 10)
        humidityLabel.topToBottom(of: dateLabel, offset: 10)

        currentWeatherConditionLabel.centerY(to: contentView)
        currentWeatherConditionLabel.leadingToTrailing(of: humidityLabel, offset: 20)

        temperatureLabel.centerY(to: contentView)
        temperatureLabel.leadingToTrailing(of:  currentWeatherConditionLabel, offset: 40)
        
        seeMoreDetailLabel.centerY(to: contentView)
        seeMoreDetailLabel.leadingToTrailing(of: temperatureLabel, offset: 30)
    }
}
