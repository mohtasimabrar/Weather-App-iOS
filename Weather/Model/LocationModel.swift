//
//  LocationModel.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import Foundation

struct LocationModel: Codable {
    var name: String = "Dhaka"
    var localNames: [String: String]?
    var lat: Double = 23.8041
    var lon: Double = 90.4152
    var country: String?
    var state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}
