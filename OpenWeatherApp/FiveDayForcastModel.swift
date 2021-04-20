//
//  FiveDayForcastModel.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//

import Foundation

// MARK: - FiveWeekModel
struct FiveWeekModel: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [FList]?
    let city: FCity?
}

// MARK: - List
struct FList: Codable {
    let dt: Int64?
    let main: FMainClass?
    let weather: [FWeather]?
    let clouds: FClouds?
    let wind: FWind?
    let visibility: Int64?
    let pop: Double?
    let sys: FSys?
    let dtTxt: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - City
struct FCity: Codable {
    let id: Int?
    let name: String?
    let coord: FCoord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct FCoord: Codable {
    let lat, lon: Double?
}

// MARK: - Clouds
struct FClouds: Codable {
    let all: Int?
}

// MARK: - MainClass
struct FMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Sys
struct FSys: Codable {
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct FWeather: Codable {
    let id: Int?
    let main: MainEnum?
    let weatherDescription: FDescription?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"

}

enum FDescription: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case overcastClouds = "overcast clouds"
    case lightRain = "light rain"
    case scatteredClouds = "scattered clouds"
}

// MARK: - Wind
struct FWind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

