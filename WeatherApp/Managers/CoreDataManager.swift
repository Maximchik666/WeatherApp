//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 27.02.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init () {}
    
    
    // Создаем контейнер
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Сохранение контекста
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Удаление конкретного прогноза из КорДаты
    func deleteForecast (forecast: DailyForecastDataModel) {
        persistentContainer.viewContext.delete(forecast)
        saveContext()
    }
    
    // Создание Прогноза из распарсеных из Джейсона Данных и сохранение их в Кор дате.
    func addForecasts(dailyForecast: WeatherForecast, completion: @escaping ()->()) {
        persistentContainer.performBackgroundTask { contextBackground in
            for i in 0...6 {
                let forecast = DailyForecastDataModel(context: contextBackground)
                forecast.id = Int64(i)
                forecast.windSpeed  = dailyForecast.forecasts[i].dailyForecast.dayShort.windSpeed
                forecast.highestTemp = Int64(dailyForecast.forecasts[i].dailyForecast.dayShort.temp)
                forecast.lowestTemp = Int64(dailyForecast.forecasts[i].dailyForecast.nightShort.temp)
                forecast.dawnTime = dailyForecast.forecasts[i].sunrise
                forecast.sunsetTime = dailyForecast.forecasts[i].sunset
                forecast.currentTemp = Int64(dailyForecast.currentWeather.temp)
                forecast.humidity = Int64(dailyForecast.forecasts[i].dailyForecast.dayShort.humidity)
                forecast.weatherCondition = {
                    switch dailyForecast.forecasts[i].dailyForecast.dayShort.condition {
                    case "clear": return "ясно"
                    case "partly": return "малооблачно"
                    case "cloudy": return "облачно"
                    case "overcast": return "пасмурно"
                    case "drizzle": return "морось"
                    case "light-rain": return "небольшой дождь"
                    case "rain": return "дождь"
                    case "moderate-rain": return "дождь"
                    case "heavy-rain": return "сильный дождь"
                    case "continuous-heavy-rain": return "сильный дождь"
                    case "showers": return "ливень"
                    case "wet-snow": return "дождь со снегом"
                    case "light-snow": return "небольшой снег"
                    case "snow": return "снег"
                    case "snow-showers": return "снегопад"
                    case "hail": return "град"
                    case "thunderstorm": return "гроза"
                    case "thunderstorm-with-rain": return "дождь с грозой"
                    case "thunderstorm-with-hail": return "гроза с градом"
                    default: return "нет данных"
                    }
                }()
                forecast.image = {
                    switch dailyForecast.forecasts[i].dailyForecast.dayShort.condition {
                    case "clear": return "CurrentWeather.Sun"
                    case "partly": return "CurrentWeather.LightClouds"
                    case "cloudy": return "CurrentWeather.Clouds"
                    case "overcast": return "CurrentWeather.Overcast"
                    case "drizzle": return "CurrentWeather.LightRain"
                    case "light-rain": return "CurrentWeather.LightRain дождь"
                    case "rain": return "CurrentWeather.Rain"
                    case "moderate-rain": return "CurrentWeather.Rain"
                    case "heavy-rain": return "CurrentWeather.Rain"
                    case "continuous-heavy-rain": return "CurrentWeather.Rain"
                    case "showers": return "CurrentWeather.Rain"
                    case "wet-snow": return "CurrentWeather.Rain"
                    case "light-snow": return "CurrentWeather.Rain"
                    case "snow": return "CurrentWeather.Rain"
                    case "snow-showers": return "CurrentWeather.Rain"
                    case "hail": return "CurrentWeather.Rain"
                    case "thunderstorm": return "CurrentWeather.Thunder"
                    case "thunderstorm-with-rain": return "CurrentWeather.Thunder"
                    case "thunderstorm-with-hail": return "CurrentWeather.Thunder"
                    default: return "CurrentWeather.Sun"
                    }
                }()
                forecast.cloudiness = dailyForecast.forecasts[i].dailyForecast.dayShort.cloudness
                forecast.date = self.dateFormatter(unformattedDate: dailyForecast.forecasts[i].date)
                forecast.geolocation = dailyForecast.info.locationInfo.name
                if i <= 1 { // Так как АПИ отдает почасовой прогноз только на 2 дня
                    for h in 0...23 {
                        let hourForecast = HourlyForecastDataModel(context: contextBackground)
                        hourForecast.cloudness = dailyForecast.forecasts[i].hourlyForecast[h].cloudness
                        hourForecast.condition = dailyForecast.forecasts[i].hourlyForecast[h].condition
                        hourForecast.humidity = Int64(dailyForecast.forecasts[i].hourlyForecast[h].humidity)
                        hourForecast.windSpeed = dailyForecast.forecasts[i].hourlyForecast[h].windSpeed
                        hourForecast.temp = Int64(dailyForecast.forecasts[i].hourlyForecast[h].temp)
                        hourForecast.hour = dailyForecast.forecasts[i].hourlyForecast[h].hour
                        hourForecast.feelsLike = Int64(dailyForecast.forecasts[i].hourlyForecast[h].feelsLike)
                        hourForecast.precStrength = dailyForecast.forecasts[i].hourlyForecast[h].precStrength
                        hourForecast.precType = Int64(dailyForecast.forecasts[i].hourlyForecast[h].precType)
                        hourForecast.id = Int64(h)
                        hourForecast.image = {
                            switch dailyForecast.forecasts[i].hourlyForecast[h].condition {
                            case "clear": return "CurrentWeather.Sun"
                            case "partly": return "CurrentWeather.LightClouds"
                            case "cloudy": return "CurrentWeather.Clouds"
                            case "overcast": return "CurrentWeather.Overcast"
                            case "drizzle": return "CurrentWeather.LightRain"
                            case "light-rain": return "CurrentWeather.LightRain дождь"
                            case "rain": return "CurrentWeather.Rain"
                            case "moderate-rain": return "CurrentWeather.Rain"
                            case "heavy-rain": return "CurrentWeather.Rain"
                            case "continuous-heavy-rain": return "CurrentWeather.Rain"
                            case "showers": return "CurrentWeather.Rain"
                            case "wet-snow": return "CurrentWeather.Rain"
                            case "light-snow": return "CurrentWeather.Rain"
                            case "snow": return "CurrentWeather.Rain"
                            case "snow-showers": return "CurrentWeather.Rain"
                            case "hail": return "CurrentWeather.Rain"
                            case "thunderstorm": return "CurrentWeather.Thunder"
                            case "thunderstorm-with-rain": return "CurrentWeather.Thunder"
                            case "thunderstorm-with-hail": return "CurrentWeather.Thunder"
                            default: return "CurrentWeather.Sun"
                            }
                        }()
                        forecast.addToHourlyForecast(hourForecast)
                    }
                }
            }
            try? contextBackground.save()
            completion()
        }
    }
    
    // Очистка всей базы данных КорДаты
    func clearDataBase() {
        let fetchRequest = DailyForecastDataModel.fetchRequest()
        for forecast in (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
            deleteForecast(forecast: forecast)
            
        }
    }
    
    // Форматирование даты из вида предоставляемого АПИ в нужный
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
    
    
}
