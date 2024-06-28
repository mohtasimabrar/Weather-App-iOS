//
//  WeatherFeatureView.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import SwiftUI

struct WeatherFeatureView: View {
    
    @Binding var features: [WeatherFeatureModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach($features, id: \.self.id) { feature in
                    CardView(feature: feature)
                }
            }
            .frame(width: .infinity, height: 100)
            .padding(.horizontal)
        }
    }
    
}
