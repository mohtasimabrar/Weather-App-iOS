//
//  RequestManager.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import Foundation
import Combine
import Alamofire
import SVProgressHUD

class RequestManager {
    static let shared: RequestManager = RequestManager()
    func getCurrentData(lat: Double, long: Double) -> AnyPublisher<CurrentWeather, AFError> {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
        return AF.request(AppConstants.Networking.getCurrentWeatherURL(lat: lat, long: long), method: .get)
            .validate()
            .publishDecodable(type: CurrentWeather.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getGeoLocationSuggestions(query: String) -> AnyPublisher<[LocationModel], AFError> {
        return AF.request(AppConstants.Networking.getGeoLocationURL(query: query), method: .get)
            .validate()
            .publishDecodable(type: [LocationModel].self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
