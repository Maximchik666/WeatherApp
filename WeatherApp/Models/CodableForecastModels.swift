import Foundation

// MARK: - WeatherForecast
struct WeatherForecast: Codable {
    let now: Int
    let info: Info
    let currentWeather: Fact
    let forecasts: [Forecast]
}

// MARK: - Info
struct Info: Codable {
    let lat, lon: Double
    let locationInfo: LocationInfo
    let defPressureMm: Int
}

// MARK: - LocationInfo
struct LocationInfo: Codable {
    let offset: Int
    let name, abbr: String
}

// MARK: - Fact
struct Fact: Codable {
    
    let temp, feelsLike: Int
    let condition: String
    let windSpeed: Double
    let humidity: Int
    let precType: Int
    let precStrength: Double
    let cloudness: Double
    /*
     condition - Состояние погоды
     
     clear — ясно.
     partly-cloudy — малооблачно.
     cloudy — облачно с прояснениями.
     overcast — пасмурно.
     drizzle — морось.
     light-rain — небольшой дождь.
     rain — дождь.
     moderate-rain — умеренно сильный дождь.
     heavy-rain — сильный дождь.
     continuous-heavy-rain — длительный сильный дождь.
     showers — ливень.
     wet-snow — дождь со снегом.
     light-snow — небольшой снег.
     snow — снег.
     snow-showers — снегопад.
     hail — град.
     thunderstorm — гроза.
     thunderstorm-with-rain — дождь с грозой.
     thunderstorm-with-hail — гроза с градом.
     =========================================
     precType - Тип Осадков
     0 — без осадков. 1 — дождь. 2 — дождь со снегом. 3 — снег.
     =========================================
     precStrength - Сила осадков
     0 — без осадков. 0.25 — слабый дождь/слабый снег.
     0.5 — дождь/снег.
     0.75 — сильный дождь/сильный снег.
     1 — сильный ливень/очень сильный снег.
     */
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let dateTs: Int
    let sunrise, sunset: String
    let dailyForecast: DailyForecast
    let hourlyForecast: [HourFact]
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let dayShort: Fact
    let nightShort: Fact
}

// MARK: - HourForecast
struct HourFact: Codable {
    let hour: String
    let temp: Int
    let feelsLike: Int
    let condition: String
    let windSpeed: Double
    let humidity: Int
    let precType: Int  //0 — без осадков. 1 — дождь. 2 — дождь со снегом. 3 — снег.
    let precStrength: Double
    let cloudness: Double
}

// ======================================================================================================================================

// MARK: - Extensions With CodingKeys
extension WeatherForecast {
    enum CodingKeys: String, CodingKey {
        case now
        case info
        case currentWeather = "fact"
        case forecasts
    }
}

extension Info {
    enum CodingKeys: String, CodingKey {
        case lat, lon
        case locationInfo = "tzinfo"
        case defPressureMm = "def_pressure_mm"
    }
}

extension Fact {
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case humidity
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case cloudness
    }
}

extension Forecast {
    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case sunrise, sunset
        case dailyForecast = "parts"
        case hourlyForecast = "hours"
    }
}

extension DailyForecast {
    enum CodingKeys: String, CodingKey {
        case dayShort = "day_short"
        case nightShort = "night_short"
    }
}

extension HourFact {
    enum CodingKeys: String, CodingKey {
        case hour
        case temp
        case feelsLike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case humidity
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case cloudness
    }
}
