//
//  AppState.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import Foundation

enum Unit: String {
    case standard
    case metric
    case imperial
}

class AppState {
    static let shared = AppState()
    
    var unit: Unit = .metric
    var isCurrentLocation = true
}
