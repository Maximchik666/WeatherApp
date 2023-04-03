//
//  DailyForecastMainScreenTableCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import UIKit
import TinyConstraints

final class DailyForecastMainScreenTableViewCell: UITableViewCell {
    
    var dataForDailyWeatherCell = DailyForecastViewModel(image: "", feelsLike: 0, id: "", highestTemp: 0, lowestTemp: 0, currentTemp: 0, weatherCondition: "", date: "", windSpeed: 0, dawnTime: "", sunsetTime: "", cloudiness: 0, humidity: 0, geolocation: "", hourlyForecast: [])
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.text = self.dataForDailyWeatherCell.date
        label.font = UIFont(name: "Rubik-Medium", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lightBlueRectangle : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackGround")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentWeatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: self.dataForDailyWeatherCell.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        label.text = ""
        label.font = UIFont(name: "Rubik-Regular", size: 27.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, date: String, humidity: Int, weatherCondition: String, lowestTemp: Int, highestTemp: Int, image: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dataForDailyWeatherCell.date = date
        dataForDailyWeatherCell.humidity = humidity
        dataForDailyWeatherCell.weatherCondition = weatherCondition
        dataForDailyWeatherCell.lowestTemp = lowestTemp
        dataForDailyWeatherCell.highestTemp = highestTemp
        dataForDailyWeatherCell.image = image
        
        addingSubviews()
        addingConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func addingSubviews(){
        
        addSubview(lightBlueRectangle)
        addSubview(dateLabel)
        addSubview(currentWeatherIcon)
        addSubview(temperatureLabel)
        addSubview(seeMoreDetailLabel)
        addSubview(currentWeatherConditionLabel)
    }
    
    private func addingConstraints() {
        
        
        lightBlueRectangle.edgesToSuperview(insets: TinyEdgeInsets(
            top: 5,
            left: 10,
            bottom: 5,
            right: 10),
            usingSafeArea: true)
        
        dateLabel.leading(to: lightBlueRectangle, offset: 10)
        dateLabel.top(to: lightBlueRectangle, offset: 5)
        
        currentWeatherIcon.topToBottom(of: dateLabel, offset: 0)
        currentWeatherIcon.leftToSuperview(offset: 30)
        currentWeatherIcon.height(36)
        currentWeatherIcon.width(36)
        
        seeMoreDetailLabel.centerY(to: lightBlueRectangle)
        seeMoreDetailLabel.rightToSuperview(offset: -20)
        
        temperatureLabel.centerY(to: lightBlueRectangle)
        temperatureLabel.rightToLeft(of: seeMoreDetailLabel, offset: -10)
        
        currentWeatherConditionLabel.centerY(to: lightBlueRectangle)
        currentWeatherConditionLabel.centerX(to: lightBlueRectangle)
    }
}
