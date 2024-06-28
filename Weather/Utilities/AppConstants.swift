//
//  AppConstants.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import Foundation

struct AppConstants {
    struct Networking {
        static let apiKey = "adaf78c5273c111a39ec0c58bf94da1e"
        static let baseUrl = "https://api.openweathermap.org/"
        static let currentWeatherEndpoint = "data/2.5/weather?lat=%@&lon=%@&appid=%@&units=%@"
        static let geoLocationEndpoint = "geo/1.0/direct?q=%@&limit=5&appid=%@"
        
        static func getCurrentWeatherURL(lat: Double, long: Double) -> String {
            return baseUrl + String(format: currentWeatherEndpoint, String(lat), String(long), apiKey, AppState.shared.unit.rawValue)
        }
        
        static func getGeoLocationURL(query: String) -> String {
            return baseUrl + String(format: geoLocationEndpoint, query, apiKey)
        }
        
        static func getAssetURL(icon: String) -> String {
            return "https://openweathermap.org/img/wn/\(icon)@2x.png"
        }
    }
}
