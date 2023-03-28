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
    
    // Создание Прогноза из распарсеных из Джейсона Данных и сохранение их в КорДате.
    func addForecasts(dailyForecast: WeatherForecast, completion: @escaping ()->()) {
        persistentContainer.performBackgroundTask { contextBackground in
            for i in 0...6 {
                let forecast = DailyForecastDataModel(context: contextBackground)
                forecast.id = Int64(i)
                forecast.feelsLike = Int64(dailyForecast.forecasts[i].dailyForecast.dayShort.feelsLike)
                forecast.windSpeed  = dailyForecast.forecasts[i].dailyForecast.dayShort.windSpeed
                forecast.highestTemp = Int64(dailyForecast.forecasts[i].dailyForecast.dayShort.temp)
                forecast.lowestTemp = Int64(dailyForecast.forecasts[i].dailyForecast.nightShort.temp)
                forecast.dawnTime = dailyForecast.forecasts[i].sunrise
                forecast.sunsetTime = dailyForecast.forecasts[i].sunset
                forecast.currentTemp = Int64(dailyForecast.currentWeather.temp)
                forecast.humidity = Int64(dailyForecast.forecasts[i].dailyForecast.dayShort.humidity)
                forecast.weatherCondition = {
                    switch dailyForecast.forecasts[i].dailyForecast.dayShort.condition {
                    case "clear": return "Ясно"
                    case "partly": return "Малооблачно"
                    case "cloudy": return "Облачно"
                    case "overcast": return "Пасмурно"
                    case "drizzle": return "Морось"
                    case "light-rain": return "Небольшой дождь"
                    case "rain": return "Дождь"
                    case "moderate-rain": return "Дождь"
                    case "heavy-rain": return "Сильный дождь"
                    case "continuous-heavy-rain": return "Сильный дождь"
                    case "showers": return "Ливень"
                    case "wet-snow": return "Дождь со снегом"
                    case "light-snow": return "Небольшой снег"
                    case "snow": return "Снег"
                    case "snow-showers": return "Снегопад"
                    case "hail": return "Срад"
                    case "thunderstorm": return "Гроза"
                    case "thunderstorm-with-rain": return "Дождь с грозой"
                    case "thunderstorm-with-hail": return "Гроза с градом"
                    default: return "Нет данных"
                    }
                }()
                forecast.image = {
                    switch dailyForecast.forecasts[i].dailyForecast.dayShort.condition {
                    case "clear": return "CurrentWeather.Sun"
                    case "partly": return "CurrentWeather.LightClouds"
                    case "cloudy": return "CurrentWeather.Clouds"
                    case "overcast": return "CurrentWeather.Overcast"
                    case "drizzle": return "CurrentWeather.LightRain"
                    case "light-rain": return "CurrentWeather.LightRain"
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
                forecast.date = dateFormatter(unformattedDate: dailyForecast.forecasts[i].date)
                forecast.geolocation = dailyForecast.info.locationInfo.name
                if i <= 1 { // Так как АПИ отдает почасовой прогноз только на 2 дня
                    for h in 0...23 {
                        let hourForecast = HourlyForecastDataModel(context: contextBackground)
                        hourForecast.date = forecast.date
                        hourForecast.cloudness = dailyForecast.forecasts[i].hourlyForecast[h].cloudness
                        hourForecast.condition = {
                            switch dailyForecast.forecasts[i].hourlyForecast[h].condition {
                            case "clear": return "Ясно"
                            case "partly": return "Малооблачно"
                            case "cloudy": return "Облачно"
                            case "overcast": return "Пасмурно"
                            case "drizzle": return "Морось"
                            case "light-rain": return "Небольшой дождь"
                            case "rain": return "Дождь"
                            case "moderate-rain": return "Дождь"
                            case "heavy-rain": return "Сильный дождь"
                            case "continuous-heavy-rain": return "Сильный дождь"
                            case "showers": return "Ливень"
                            case "wet-snow": return "Дождь со снегом"
                            case "light-snow": return "Небольшой снег"
                            case "snow": return "Снег"
                            case "snow-showers": return "Снегопад"
                            case "hail": return "Срад"
                            case "thunderstorm": return "Гроза"
                            case "thunderstorm-with-rain": return "Дождь с грозой"
                            case "thunderstorm-with-hail": return "Гроза с градом"
                            default: return "Нет данных"
                            }
                        }()
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
                            case "light-rain": return "CurrentWeather.LightRain"
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
    
    func addInitialCoordinates(longitude: Double, lattitude: Double, locationName: String, completion: @escaping ()->()) {
        persistentContainer.performBackgroundTask { contextBackground in
            let coord = InitialCoordinates(context: contextBackground)
            coord.longitude = longitude
            coord.lattitude = lattitude
            coord.locationName = locationName
            try? contextBackground.save()
            completion()
        }
    }
    
    // Очистка всей базы данных КорДаты
    func clearForecastDataBase() {
        let fetchRequest = DailyForecastDataModel.fetchRequest()
        for forecast in (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
            deleteForecast(forecast: forecast)
            
        }
    }
    
    func clearInitialCoordinatesDataBase(){
        let fetchRequest = InitialCoordinates.fetchRequest()
        for coord in (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []{
            persistentContainer.viewContext.delete(coord)
            saveContext()
        }
    }
}
