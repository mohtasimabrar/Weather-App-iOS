//
//  ContentView.swift
//  Weather
//
//  Created by Samin on 27/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State var isSearching = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                if isSearching && !viewModel.searchText.isEmpty {
                    searchResultView
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            QuickGlanceView(weatherData: $viewModel.currentWeatherData)
                                .padding(.horizontal)
                            WeatherFeatureView(features: $viewModel.currentWeatherData.features)
                            AtmosphereDetailsView(features: $viewModel.currentWeatherData.features)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.initialSetup()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.currentWeatherData.locationName)
            .searchable(text: $viewModel.searchText, isPresented: $isSearching, prompt: "Find a location")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        viewModel.fetchCurrentWeatherData()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .tint(.black)
                    }
                }
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Menu {
                        Button {
                            viewModel.updateUnit()
                        } label: {
                            Text("C/F")
                        }
                        Button {
                            viewModel.setLiveLocation()
                        } label: {
                            Text("Current Location")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .tint(.black)
                    }
                }
            }
        }
    }
    
    var searchResultView: some View {
        ScrollView {
            VStack {
                ForEach(Array(viewModel.searchResults.enumerated()), id: \.element) { index, element in
                    Button {
                        viewModel.updateLocation(index: index)
                        isSearching = false
                    } label: {
                        HStack {
                            Text("\(element)")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                    
                }
            }
        }
    }
}
