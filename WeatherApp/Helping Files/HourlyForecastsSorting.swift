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
    
    var unsortedToday : [HourlyForecastDataModel] = []
    var unsortedTomorrow : [HourlyForecastDataModel] = []
    
    // Собираем все часовые прогнозы сегодняшнего дня в один массив
    for i in forecasts[0].hourlyForecast!.allObjects {
        unsortedToday.append(i as! HourlyForecastDataModel)
    }
    // Сортируем этот массив по возрастанию (id это номер часа)
    var sortedToday = unsortedToday.sorted{$0.id < $1.id }
    // Удаляем все часовые прогнозы номер часа которых меньше текущего
    sortedToday.removeAll{$0.id < currentHour}
    
    // Собираем все часовые прогнозы завтрашено дня в один массив
    for i in forecasts[1].hourlyForecast!.allObjects {
        unsortedTomorrow.append(i as! HourlyForecastDataModel)
    }
    
    // Удаляем ненужные прогнозы завтрашнего дня (чтобы общее число прогнозов было равно параметру метода)
    var sortedTomorrow = unsortedTomorrow.sorted{$0.id < $1.id }
    sortedTomorrow.removeAll{$0.id >= (currentHour - (24 - hours))}
    
    return sortedToday + sortedTomorrow
}
