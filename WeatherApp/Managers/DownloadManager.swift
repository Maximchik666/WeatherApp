//
//  DownloadManager.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import Alamofire


final class DownloadManager {
    
    func downloadWeather (coordinates: (Double, Double, String), complition: @escaping (String) -> ()) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=\(coordinates.0)&lon=\(coordinates.1)&&limit=7&extra=true"
        let header: HTTPHeaders = ["X-Yandex-API-Key": "cdb1cf02-d38f-4913-852e-af24e6951369"]
        
        AF.request(url, headers: header)
            .validate()
            .responseDecodable(of: WeatherForecast.self) { (response) in
                
                if let weather = response.value {
                    
                    CoreDataManager.shared.addForecasts(dailyForecast: weather) {
                        complition(coordinates.2)
                    }
                } else {
                    print(response)
                }
            }
    }
}
