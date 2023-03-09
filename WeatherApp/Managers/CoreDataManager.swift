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
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
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
    
    func deleteForecast (forecast: DailyForecastDataModel) {
        persistentContainer.viewContext.delete(forecast)
        saveContext()
    }
    
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
                forecast.weatherCondition = dailyForecast.forecasts[i].dailyForecast.dayShort.condition
                forecast.cloudiness = dailyForecast.forecasts[i].dailyForecast.dayShort.cloudness
                forecast.date = dailyForecast.forecasts[i].date
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
                        forecast.addToHourlyForecast(hourForecast)
                    }
                }
            }
            try? contextBackground.save()
            completion()
        }
    }
    
    func clearDataBase() {
        let fetchRequest = DailyForecastDataModel.fetchRequest()
        for forecast in (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
            deleteForecast(forecast: forecast)
            
        }
    }
    
}
