//
//  WeatherDataSourceProtocol.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import Combine
import Foundation

protocol WeatherDataSourceProtocol: AnyObject {
    func getCurrentWeatherData(lat: Double, long: Double) -> Future<CurrentWeather, Never>
    func getGeoLocationSuggestions(query: String) -> Future<[LocationModel], Never>
}
