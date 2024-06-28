//
//  QuickGlanceView.swift
//  Weather
//
//  Created by Samin on 28/6/24.
//

import SwiftUI

struct QuickGlanceView: View {
    
    @Binding var weatherData: WeatherBaseModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text(weatherData.time)
                    .fontWeight(.semibold)
                HStack(spacing: 0) {
                    VStack() {
                        Text("\(weatherData.temp)°")
                            .font(.system(size: 56, weight: .bold))
                        Text("\(weatherData.maxTemp)°/\(weatherData.minTemp)°")
                            .font(.system(size: 14))
                            .frame(width: (proxy.size.width - 21) / 2)
                    }
                    Rectangle()
                        .frame(width: 1, height: 100)
                    VStack {
                        AsyncImage(url: URL(string: AppConstants.Networking.getAssetURL(icon: weatherData.icon))) { phase in
                            if let image = phase.image {
                                // Display the loaded image
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 62, height: 62)
                            }
                        }
                        
                        Text(weatherData.condition)
                            .font(.system(size: 14))
                            .frame(width: (proxy.size.width - 21) / 2)
                    }
                    
                }
                .padding(10)
                Text("Feels like \(weatherData.feelsLike)°")
                Text(weatherData.conditionDesc)
            }
        }
        .foregroundColor(.white)
        .padding(10)
        .padding(.vertical)
        .background {
            Color.accentColor
        }
        .cornerRadius(12)
        .frame(height: 270)
        .shadow(color: Color.gray.opacity(0.1), radius: 5)
    }
}
