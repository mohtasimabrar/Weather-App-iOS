//
//  WeatherDataSource.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import Foundation
import Combine
import Alamofire
import SVProgressHUD

class WeatherDataSource: WeatherDataSourceProtocol {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func getGeoLocationSuggestions(query: String) -> Future<[LocationModel], Never> {
        return Future() { promise in
            RequestManager.shared.getGeoLocationSuggestions(query: query)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                        print(error.localizedDescription)
                    }
                } receiveValue: { data in
                    promise(Result.success(data))
                }
                .store(in: &self.subscriptions)
        }
    }
    
    func getCurrentWeatherData(lat: Double, long: Double) -> Future<CurrentWeather, Never> {
        return Future() { promise in
            RequestManager.shared.getCurrentData(lat: lat, long: long)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                        print(error.localizedDescription)
                    }
                } receiveValue: { data in
                    promise(Result.success(data))
                }
                .store(in: &self.subscriptions)
        }
    }
}
