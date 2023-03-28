//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 28.03.2023.
//

import Foundation

// Форматирование даты из вида предоставляемого АПИ в нужный для отображения
func dateFormatter (unformattedDate: String) -> String {
    let dateFormatter = DateFormatter()
    
    // Устанавливаем формат даты и локаль
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "ru_RU_POSIX")
    
    // Преобразуем строку в дату
    guard let date = dateFormatter.date(from: unformattedDate) else {
        fatalError("Неверный формат даты")
    }
    
    // Обновляем формат даты
    dateFormatter.dateFormat = "dd MMMM"
    
    // Преобразуем дату в строку с новым форматом
    let newDateString = dateFormatter.string(from: date)
    
    return newDateString
}
