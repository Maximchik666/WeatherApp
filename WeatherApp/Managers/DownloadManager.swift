//
//  DownloadManager.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import Alamofire


class DownloadManager {
    
    func downloadWeather (complition: @escaping () -> ()) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&&limit=7&extra=true"
        let header: HTTPHeaders = ["X-Yandex-API-Key": "22cb5ee0-222b-4aa0-b8db-fffa4def517e"]
        
        AF.request(url, headers: header)
            .validate()
            .responseDecodable(of: WeatherForecast.self) { (response) in
                
                if let weather = response.value {
                    
                    CoreDataManager.shared.addForecasts(dailyForecast: weather) {
                        complition()
                    }
                    
                } else {
                    print(response)
                }
            }
    }
}

