//
//  ListView.swift
//  Weather
//
//  Created by Samin on 29/6/24.
//

import Foundation
import SwiftUI

struct ListView: View {
    
    @Binding var feature: WeatherFeatureModel
    
    var body: some View {
        HStack {
            Image(systemName: feature.type.rawValue)
                .foregroundStyle(Color.accentColor)
                .frame(width: 25)
                .aspectRatio(contentMode: .fit)
            Text(feature.title)
                .font(.system(size: 16))
            Spacer()
            Text(feature.value)
                .font(.system(size: 16, weight: .medium))
        }
    }
}
