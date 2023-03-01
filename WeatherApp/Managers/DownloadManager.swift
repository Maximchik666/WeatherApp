//
//  DownloadManager.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import Alamofire


class DownloadManager {
    
    func downloadWeather (complition: @escaping ()->()) {
        
      //  let url1 = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&extra=true")!
      //  let url = URL(string:  "https://api.openweathermap.org/data/2.5/weather?lat=55.75396&lon=37.620393&appid=5474d9dfba0f85a72af4b0e829f5e267")
      //  let header: HTTPHeaders = ["X-Yandex-API-Key": "22cb5ee0-222b-4aa0-b8db-fffa4def517e"]

        let request = AF.request("https://api.openweathermap.org/data/2.5/weather?q=Omsk,ru&APPID=c0e216da8787c982bc9a94b18f25c3b7&units=metric")
            .validate()
            .responseDecodable(of: Welcome.self) { (response) in
                let weather = response.value
                print(weather)
                
                WeatherViewModelSingletone.shared.cloudiness = weather?.clouds.cloudiness ?? 00
                WeatherViewModelSingletone.shared.humidity = weather?.main.humidity ?? 00
                WeatherViewModelSingletone.shared.currentTemp = Int(weather?.main.temp ?? 00)
                WeatherViewModelSingletone.shared.highestTemp = Int(weather?.main.tempMax ?? 00)
                WeatherViewModelSingletone.shared.id = weather?.id ?? 00
                WeatherViewModelSingletone.shared.windSpeed = Int(weather?.wind.speed ?? 00)
                WeatherViewModelSingletone.shared.weatherCondition = weather?.weather[0].fullDescription ?? "ERROR"
                
                complition()
            }
    }
}
