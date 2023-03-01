// MARK: - Welcome
struct Welcome: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let id: Int
    let name: String
    let clouds: Clouds
}

// MARK: - Main
struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
       
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let cloudiness: Int
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}


// MARK: - Weather
struct Weather: Codable {
    let description, fullDescription: String
    
    enum CodingKeys: String, CodingKey {
        case description = "main"
        case fullDescription = "description"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}
