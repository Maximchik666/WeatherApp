//
//  WeatherVievModel.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 22.02.2023.
//

import Foundation

struct DailyForecastViewModel {
    
    var id: String
    var highestTemp:Int
    var lowestTemp: Int
    var currentTemp: Int
    var weatherCondition: String
    var date: Date
    var windSpeed: Int
    var dawnTime: String
    var sunsetTime: String
    var cloudiness: Int
    var humidity: Int
    var hourlyForecast: [HourlyForecastViewModel]
    
}

struct WeatherViewModelSingletone {
    
    static var shared = DailyForecastViewModel(id: UUID().uuidString, highestTemp: 0, lowestTemp: 0, currentTemp: 0, weatherCondition: "", date: Date(), windSpeed: 0, dawnTime: "", sunsetTime: "", cloudiness: 0, humidity: 0, hourlyForecast: [])
}