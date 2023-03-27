//
//  HourlyForecastsSorting.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.03.2023.
//

import Foundation


// Функция, которая отдает отсортированый массив из 12 Часовых прогнозов, начиная с текущего часа на устройсте
func getTimeSortedHourForecasts(from forecasts: [DailyForecastDataModel], forHowMuchHours hours: Int) -> [HourlyForecastDataModel] {
    
    var currentHour: Int {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    
    var unsorted1 : [HourlyForecastDataModel] = []
    var unsorted2 : [HourlyForecastDataModel] = []
    
    for i in forecasts[0].hourlyForecast!.allObjects {
        unsorted1.append(i as! HourlyForecastDataModel)
    }
    
    var sorted1 = unsorted1.sorted{$0.id < $1.id }
    sorted1.removeAll{$0.id < currentHour}
    
    for i in forecasts[1].hourlyForecast!.allObjects {
        unsorted2.append(i as! HourlyForecastDataModel)
    }
    
    var sorted2 = unsorted2.sorted{$0.id < $1.id }
    sorted2.removeAll{$0.id >= (currentHour - (24 - hours))}
    
    return sorted1 + sorted2
}
