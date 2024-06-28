//
//  WeatherBaseModel.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import Foundation

enum WeatherFeatureModelCase: String {
    case windSpeed = "wind"
    case sunrise = "sunrise"
    case sunset = "sunset"
    case visibility = "eye"
    case pressure = "barometer"
    case humidity = "humidity"
    case cloudiness = "cloud"
}

struct WeatherBaseModel {
    var locationName: String
    var time: String
    var temp: String
    var feelsLike: String
    var maxTemp: String
    var minTemp: String
    var icon: String
    var condition: String
    var conditionDesc: String
    var features: [WeatherFeatureModel]
}

struct WeatherFeatureModel {
    let id: UUID = UUID()
    var title: String
    var type: WeatherFeatureModelCase
    var value: String
}
