//
//  WeatherVievModel.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 22.02.2023.
//

import Foundation

struct DailyForecastViewModel {
    
    var image: String
    var id: String
    var highestTemp:Int
    var lowestTemp: Int
    var currentTemp: Int
    var weatherCondition: String
    var date: String
    var windSpeed: Double
    var dawnTime: String
    var sunsetTime: String
    var cloudiness: Double
    var humidity: Int
    var geolocation: String
    var hourlyForecast: [HourlyForecastViewModel]
}
