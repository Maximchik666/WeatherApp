//
//  WeatherVievModel.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 22.02.2023.
//

import Foundation

struct WeatherViewModel {
    
    var id: Int
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
    
}

struct WeatherViewModelSingletone {
    
    static var shared = WeatherViewModel(id: 0, highestTemp: 0, lowestTemp: 0, currentTemp: 0, weatherCondition: "", date: Date(), windSpeed: 0, dawnTime: "", sunsetTime: "", cloudiness: 0, humidity: 0)
}
