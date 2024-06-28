//
//  CardView.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import SwiftUI

struct CardView: View {
    
    @Binding var feature: WeatherFeatureModel
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(feature.title)
                    .foregroundStyle(Color(hex: "616161"))
                    .font(.system(size: 14))
                    .padding(.bottom, 2)
                HStack  {
                    Image(systemName: feature.type.rawValue)
                        .foregroundStyle(Color.accentColor)
                    Text(feature.value)
                        .font(.system(size: 17, weight: .medium))
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: 150, height: 80)
        .background {
            Color.white
        }
        .cornerRadius(8)
        .shadow(color: Color.gray.opacity(0.1), radius: 5)
    }
}
