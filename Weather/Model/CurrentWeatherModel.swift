//
//  WACurrentWeatherModel.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import Foundation

import Foundation

// MARK: - WeatherModel
struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    func toWeatherBaseModel() -> WeatherBaseModel {
        var features: [WeatherFeatureModel] = []
        features.append(WeatherFeatureModel(title: "Wind Speed", type: .windSpeed, value: "\(wind.speed ?? 0) \(AppState.shared.unit == .metric ? "m/s" : "m/h")"))
        features.append(WeatherFeatureModel(title: "Pressure", type: .pressure, value: "\(main.pressure) hPa"))
        features.append(WeatherFeatureModel(title: "Humidity", type: .humidity, value: "\(main.humidity)%"))
        features.append(WeatherFeatureModel(title: "Cloudiness", type: .cloudiness, value: "\(clouds.all ?? 0)%"))
        features.append(WeatherFeatureModel(title: "Visibility", type: .visibility, value: "\(visibility/1000) km"))
        features.append(WeatherFeatureModel(title: "Sunrise", type: .sunrise, value: "\(AppUtility.intervalToTime(interval: sys.sunrise, shift: timezone))"))
        features.append(WeatherFeatureModel(title: "Sunset", type: .sunset, value: "\(AppUtility.intervalToTime(interval: sys.sunset, shift: timezone))"))
        return WeatherBaseModel(
            locationName: name,
            time: AppUtility.intervalToFullDate(interval: dt, shift: timezone),
            temp: "\(Int(main.temp))",
            feelsLike: "\(Int(main.feelsLike))",
            maxTemp: "\(Int(main.tempMax))",
            minTemp: "\(Int(main.tempMin))",
            icon: weather.first?.icon ?? "",
            condition: weather.first?.main ?? "",
            conditionDesc: weather.first?.description?.capitalizingFirstLetter() ?? "",
            features: features)
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double?
    let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
