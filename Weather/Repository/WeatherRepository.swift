//
//  WeatherRepository.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import Foundation
import Combine
import MapKit

class WeatherRepository: WeatherRepositoryProtocol {
    
    private var currentWeatherDataPublisher = PassthroughSubject<WeatherBaseModel, Never>()
    private var geoLocationSuggestionsPublisher = PassthroughSubject<[String], Never>()
    private var geoLocationSuggestions: [LocationModel] = [] {
        didSet {
            updateGeoLocationPublisher()
        }
    }
    private var selectedLocation = LocationModel()
    
    private var dataSource: WeatherDataSourceProtocol
    private var subscriptions: Set<AnyCancellable> = []
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    init() {
        self.dataSource = WeatherDataSource()
    }
    
    //MARK: Geo location related
    func searchGeoLocations(forQuery: String) {
        dataSource.getGeoLocationSuggestions(query: forQuery)
            .sink { [weak self] suggestions in
                guard let self else {
                    return
                }
                print(suggestions)
                self.geoLocationSuggestions = suggestions
            }
            .store(in: &subscriptions)
    }
    
    func getGeoLocationSuggestionsPublisher() -> PassthroughSubject<[String], Never> {
        return geoLocationSuggestionsPublisher
    }
    
    func updateLocation(index: Int) {
        self.selectedLocation = geoLocationSuggestions[index]
        fetchCurrentWeatherData()
    }
    
    private func updateGeoLocationPublisher() {
        self.geoLocationSuggestionsPublisher.send(
            self.geoLocationSuggestions.map({ location in
                var string = "\(location.name)"
                if let state = location.state {
                    string += ", \(state)"
                }
                if let country = location.country {
                    string += ", \(country)"
                }
                return string
            })
        )
    }
    
    //MARK: Current weather related
    func getCurrentWeatherDataPublisher() -> PassthroughSubject<WeatherBaseModel, Never> {
        return currentWeatherDataPublisher
    }
    
    func fetchCurrentWeatherData() {
        var lat = selectedLocation.lat
        var long = selectedLocation.lon
        let group = DispatchGroup()
        if AppState.shared.isCurrentLocation {
            group.enter()
            locManager.requestWhenInUseAuthorization()
            
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
                currentLocation = locManager.location
                lat = currentLocation.coordinate.latitude
                long = currentLocation.coordinate.longitude
                group.leave()
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: .global()) { [self] in
            dataSource.getCurrentWeatherData(lat: lat, long: long)
                .sink { [weak self] weatherData in
                    guard let self else {
                        return
                    }
                    print(weatherData)
                    currentWeatherDataPublisher.send(weatherData.toWeatherBaseModel())
                }
                .store(in: &subscriptions)
        }
        
    }
    
    
}
