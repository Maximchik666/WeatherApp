//
//  TodayCell.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 01.12.2022.
//

import Foundation
import UIKit
import TinyConstraints
import CoreData

class CurrentWeatherHeader: UITableViewHeaderFooterView {
    
    var weatherForMainScreenHeader = DailyForecastViewModel(image: "", id: "", highestTemp: 0, lowestTemp: 0, currentTemp: 0, weatherCondition: "", date: "", windSpeed: 0, dawnTime: "", sunsetTime: "", cloudiness: 0, humidity: 0, geolocation: "", hourlyForecast: [])
    
    private lazy var blueRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DeepBlue")
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    private lazy var ellipse: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ellipse")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var dawnIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "DawnIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var sunsetIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SunsetIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var dawnTimeLabel: UILabel = {
        let label = UILabel()
        label.text = weatherForMainScreenHeader.dawnTime
        label.font = UIFont(name: "Rubik-Medium", size: 15.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.text = weatherForMainScreenHeader.sunsetTime
        label.font = UIFont(name: "Rubik-Medium", size: 15.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var biggestAndLowestTempLabel: UILabel = {
        let label = UILabel()
        label.text = String(weatherForMainScreenHeader.lowestTemp) + "° / " + String(weatherForMainScreenHeader.highestTemp) + "°"
        label.font = UIFont(name: "Rubik-Regular", size: 17.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.text = String(weatherForMainScreenHeader.currentTemp) + "°"
        label.font = UIFont(name: "Rubik-Regular", size: 40.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentWeatherConditionLabel: UILabel = {
        let label = UILabel()
        label.text = self.weatherForMainScreenHeader.weatherCondition
        label.font = UIFont(name: "Rubik-Regular", size: 17.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cloudinessIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "CloudinessIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var cloudinessLabel: UILabel = {
        let label = UILabel()
        label.text = String(weatherForMainScreenHeader.cloudiness)
        label.font = UIFont(name: "Rubik-Regular", size: 15.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windSpeedIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "WindSpeedIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = String(weatherForMainScreenHeader.windSpeed) + "m/s"
        label.font = UIFont(name: "Rubik-Regular", size: 15.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rainPossibilityIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RainPossibilityIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var rainPossibilitylabel: UILabel = {
        let label = UILabel()
        label.text = String(weatherForMainScreenHeader.humidity) + "%"
        label.font = UIFont(name: "Rubik-Regular", size: 15.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateAndTimeTaxtLabel: UILabel = {
        let label = UILabel()
        label.text = weatherForMainScreenHeader.date
        label.font = UIFont(name: "Rubik-Regular", size: 18.0)
        label.textColor = UIColor(named: "TextColorForDate")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init (reuseIdentifier: String?, date: String, currentTemp: Int, weatherCondition: String, windSpeed: Double, humidity: Int, cloudiness: Double, sunsetTime: String, dawnTime: String, lowestTemp: Int, highestTemp: Int) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        weatherForMainScreenHeader.date = date
        weatherForMainScreenHeader.currentTemp = currentTemp
        weatherForMainScreenHeader.weatherCondition = weatherCondition
        weatherForMainScreenHeader.windSpeed = windSpeed
        weatherForMainScreenHeader.humidity = humidity
        weatherForMainScreenHeader.cloudiness = cloudiness
        weatherForMainScreenHeader.sunsetTime = sunsetTime
        weatherForMainScreenHeader.dawnTime = dawnTime
        weatherForMainScreenHeader.lowestTemp = lowestTemp
        weatherForMainScreenHeader.highestTemp = highestTemp
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(blueRectangle)
        addSubview(ellipse)
        addSubview(dawnIcon)
        addSubview(sunsetIcon)
        addSubview(dawnTimeLabel)
        addSubview(sunsetTimeLabel)
        addSubview(biggestAndLowestTempLabel)
        addSubview(currentTempLabel)
        addSubview(currentWeatherConditionLabel)
        addSubview(cloudinessIcon)
        addSubview(windSpeedIcon)
        addSubview(rainPossibilityIcon)
        addSubview(cloudinessLabel)
        addSubview(windSpeedLabel)
        addSubview(rainPossibilitylabel)
        addSubview(dateAndTimeTaxtLabel)
    }
    
    private func setUpConstraints() {
        
        blueRectangle.edgesToSuperview(insets: TinyEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10),
            usingSafeArea: true)
        blueRectangle.height(200)
        
        ellipse.top(to: blueRectangle, offset: 10)
        ellipse.bottom(to: blueRectangle, offset: -70)
        ellipse.leading(to: blueRectangle, offset: 35)
        ellipse.trailing(to: blueRectangle,offset: -35)
        
        dawnIcon.topToBottom(of: ellipse, offset: 10)
        dawnIcon.leading(to: blueRectangle, offset:27)
        dawnIcon.height(20)
        dawnIcon.width(20)
        
        sunsetIcon.topToBottom(of: ellipse, offset: 10)
        sunsetIcon.trailing(to: blueRectangle, offset: -27)
        sunsetIcon.height(20)
        sunsetIcon.width(20)
        
        dawnTimeLabel.topToBottom(of: dawnIcon, offset: 10)
        dawnTimeLabel.leading(to: blueRectangle, offset: 18)
        dawnTimeLabel.height(15)
        
        sunsetTimeLabel.topToBottom(of: dawnIcon, offset: 10)
        sunsetTimeLabel.trailing(to: blueRectangle, offset: -18)
        sunsetTimeLabel.height(15)
        
        biggestAndLowestTempLabel.top(to: ellipse, offset: 10)
        biggestAndLowestTempLabel.centerX(to: blueRectangle)
        
        currentTempLabel.topToBottom(of: biggestAndLowestTempLabel, offset: 0)
        currentTempLabel.centerX(to: blueRectangle)
        
        currentWeatherConditionLabel.topToBottom(of: currentTempLabel, offset: 0)
        currentWeatherConditionLabel.centerX(to: blueRectangle)
        
        windSpeedIcon.topToBottom(of: currentWeatherConditionLabel, offset: 20)
        windSpeedIcon.centerX(to: blueRectangle, offset: -30)
        windSpeedIcon.height(16)
        windSpeedIcon.width(25)
        
        windSpeedLabel.centerY(to: windSpeedIcon)
        windSpeedLabel.leadingToTrailing(of: windSpeedIcon, offset: 10)
        
        cloudinessIcon.centerY(to: windSpeedIcon)
        cloudinessIcon.leading(to: blueRectangle, offset: 70)
        cloudinessIcon.height(18)
        cloudinessIcon.width(21)
        
        cloudinessLabel.centerY(to: cloudinessIcon)
        cloudinessLabel.leadingToTrailing(of: cloudinessIcon, offset: 10)
        
        rainPossibilityIcon.centerY(to: windSpeedIcon)
        rainPossibilityIcon.trailing(to: blueRectangle, offset: -100)
        rainPossibilityIcon.height(13)
        rainPossibilityIcon.width(15)
        
        rainPossibilitylabel.centerY(to: rainPossibilityIcon)
        rainPossibilitylabel.trailing(to: rainPossibilityIcon, offset: 35)
        
        dateAndTimeTaxtLabel.centerX(to: blueRectangle)
        dateAndTimeTaxtLabel.topToBottom(of: windSpeedLabel, offset: 15)
    }
}
