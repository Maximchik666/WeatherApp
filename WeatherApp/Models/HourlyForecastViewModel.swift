//
//  HourlyForecastViewModel.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 02.03.2023.
//

import Foundation

struct HourlyForecastViewModel {
   
    let hour: String
    let temp: Int
    let feelsLike: Int
    let condition: String
    let windSpeed: Double
    let humidity: Int
    let precType: Int
    let precStrength: Double
    let cloudness: Double
}
