//
//  DownloadManager.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import Alamofire

class DownloadManager {
    
    struct Fact: Codable {
        let temp, feelsLike: Int
        let icon, condition: String
        let windSpeed: Int
        let windGust: Double
        let windDir: String
        let pressureMm, pressurePa, humidity: Int
        let daytime: String
        let polar: Bool
        let season: String
        let precType: Int
        let precStrength: Double
        let isThunder: Bool
        let cloudness: Int
        let phenomIcon, phenomCondition: String
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case icon, condition
            case windSpeed = "wind_speed"
            case windGust = "wind_gust"
            case windDir = "wind_dir"
            case pressureMm = "pressure_mm"
            case pressurePa = "pressure_pa"
            case humidity, daytime, polar, season
            case precType = "prec_type"
            case precStrength = "prec_strength"
            case isThunder = "is_thunder"
            case cloudness
            case phenomIcon = "phenom_icon"
            case phenomCondition = "phenom-condition"
        }
    }
    
    
    func downloadWeather () {
        
      //  let url1 = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&extra=true")!
        let url = URL(string:  "https://api.openweathermap.org/data/2.5/weather?lat=55.75396&lon=37.620393&appid=5474d9dfba0f85a72af4b0e829f5e267")
      //  let header: HTTPHeaders = ["X-Yandex-API-Key": "22cb5ee0-222b-4aa0-b8db-fffa4def517e"]

        let request = AF.request("https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=f0f3cd4af5f96fd2b9e014c7534fda17")
        request.responseJSON { (data) in
            print(data)
        }
        
    }
}
