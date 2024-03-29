//
//  Enums.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 20.03.2023.
//

import Foundation
import UIKit

enum RubikFonts: String {
    
    case bold = "Rubik-Bold"
    case light = "Rubik-Light"
    case medium = "Rubik-Medium"
    case regular = "Rubik-Regular"
}

enum BundleImages: String {
    
    case humidity = "RainPossibilityIcon"
    case humidityBlue = "RainPossibilityIconBlue"
    case clouds = "CurrentWeather.Clouds"
    case lightClouds = "CurrentWeather.LightClouds"
    case lightRain = "CurrentWeather.LightRain"
    case rain = "CurrentWeather.Rain"
    case overcast = "CurrentWeather.Overcast"
    case sun = "CurrentWeather.Sun"
    case lightning = "CurrentWeather.Thunder"
    case termometer = "Termometer"
    case windSpeedWhite = "WindSpeedIcon"
    case windSpeedBlue = "WindSpeedIconBlue"
    case sunset = "Sunset"
}

enum BundleColours {
    case deepBlue
    case orange
    case grayText
    case backGround
    case yellow
    
    var color: UIColor {
        switch self {
        case .deepBlue: return UIColor(named: "DeepBlue")!
        case .orange: return UIColor(named: "Orange")!
        case .grayText: return UIColor(named: "GrayText")!
        case .backGround: return UIColor(named: "BackGround")!
        case .yellow: return UIColor(named: "TextColorForDate")!
        }
    }
}

enum Switchers {
    
    case notificationOn
    case notificationOff
    case temperatureCelcius
    case temperatureFarenheit
    case windMeters
    case windMiles
    
    var image: UIImage {
        switch self {
        case .notificationOn: return UIImage(named: "notif_stateON")!
        case .notificationOff: return UIImage(named: "notif_stateOFF")!
        case .temperatureCelcius: return UIImage(named: "temp_stateOFF")!
        case .temperatureFarenheit: return UIImage(named: "temp_stateON")!
        case .windMeters: return UIImage(named: "wind_stateON")!
        case .windMiles: return UIImage(named: "wind_stateOFF")!
        }
    }
}
