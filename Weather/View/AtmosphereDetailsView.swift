//
//  AtmosphereDetailsView.swift
//  Weather
//
//  Created by Samin on 29/6/24.
//

import Foundation
import SwiftUI

struct AtmosphereDetailsView: View {
    
    @Binding var features: [WeatherFeatureModel]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach($features, id: \.self.id) { feature in
                ListView(feature: feature)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.1), radius: 5)
        .padding(.horizontal)
        .padding(.bottom, 50)
    }
    
}
