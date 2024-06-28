//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import Foundation
import Combine
import SVProgressHUD

class WeatherViewModel: ObservableObject {
    @Published var currentWeatherData: WeatherBaseModel
    @Published var searchText: String = ""
    @Published var searchResults: [String] = []
    @Published var isLoading = true
    
    private var repository: WeatherRepositoryProtocol
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        self.repository = WeatherRepository()
        self.currentWeatherData = WeatherBaseModel(locationName: "--", time: "---", temp: "--", feelsLike: "--", maxTemp: "--", minTemp: "--", icon: "", condition: "---", conditionDesc: "---", features: [])
    }
    
    func initialSetup() {
        repository.getCurrentWeatherDataPublisher()
            .receive(on: DispatchQueue.main)
            .sink { weatherData in
                self.currentWeatherData = weatherData
                self.isLoading = false
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
            .store(in: &subscriptions)
        
        fetchCurrentWeatherData()
        
        repository.getGeoLocationSuggestionsPublisher()
            .receive(on: DispatchQueue.main)
            .sink { searchSuggestions in
                self.searchResults = searchSuggestions
            }
            .store(in: &subscriptions)
        
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] q in
                self?.repository.searchGeoLocations(forQuery: q)
            }
            .store(in: &subscriptions)
    }
    
    func updateLocation(index: Int) {
        AppState.shared.isCurrentLocation = false
        repository.updateLocation(index: index)
    }
    
    func setLiveLocation() {
        AppState.shared.isCurrentLocation = true
        repository.fetchCurrentWeatherData()
    }
    
    func fetchCurrentWeatherData() {
        repository.fetchCurrentWeatherData()
    }
    
    func updateUnit() {
        if AppState.shared.unit == .metric {
            AppState.shared.unit = .imperial
        } else {
            AppState.shared.unit = .metric
        }
        fetchCurrentWeatherData()
    }
}
