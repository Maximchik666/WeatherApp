//
//  DownloadManager.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import Alamofire


class DownloadManager {
    
    func downloadWeather (complition: @escaping (DailyForecastViewModel) -> ()) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&&limit=7&extra=true"
        let header: HTTPHeaders = ["X-Yandex-API-Key": "22cb5ee0-222b-4aa0-b8db-fffa4def517e"]
        var weatherForMainScreen = DailyForecastViewModel(id: "", highestTemp: 0, lowestTemp: 0, currentTemp: 0, weatherCondition: "", date: Date(), windSpeed: 0, dawnTime: "", sunsetTime: "", cloudiness: 0, humidity: 0, hourlyForecast: [])
        
        AF.request(url, headers: header)
            .validate()
            .responseDecodable(of: WeatherForecast.self) { (response) in
                
                if let weather = response.value {
                    print("JSON DOWNLOAD IS COMPLETE")
                    weatherForMainScreen.cloudiness = weather.currentWeather.cloudness
                    weatherForMainScreen.weatherCondition = weather.currentWeather.condition
                    weatherForMainScreen.windSpeed = weather.currentWeather.windSpeed
                    weatherForMainScreen.humidity = weather.currentWeather.humidity
                    weatherForMainScreen.sunsetTime = weather.forecasts[0].sunset
                    weatherForMainScreen.dawnTime = weather.forecasts[0].sunrise
                    weatherForMainScreen.lowestTemp = weather.forecasts[1].dailyForecast.nightShort.temp
                    weatherForMainScreen.highestTemp = weather.forecasts[1].dailyForecast.dayShort.temp
                    
                    complition(weatherForMainScreen)
                } else {
                    let weather = response
                    print(weather)
                }
            }
    }
}

