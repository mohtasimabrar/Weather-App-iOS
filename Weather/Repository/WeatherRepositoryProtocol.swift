//
//  WeatherRepositoryProtocol.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import Foundation
import Combine

protocol WeatherRepositoryProtocol: AnyObject {
    func fetchCurrentWeatherData()
    func getCurrentWeatherDataPublisher() -> PassthroughSubject<WeatherBaseModel, Never>
    func searchGeoLocations(forQuery: String)
    func getGeoLocationSuggestionsPublisher() -> PassthroughSubject<[String], Never>
    func updateLocation(index: Int)
}
