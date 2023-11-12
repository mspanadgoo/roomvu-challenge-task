//
//  ContentView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var forecastViewModel = ForecastViewModel()
    @StateObject private var locationViewModel = LocationViewModel()
    
    @State private var searchQuery: String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var searchHistory: [String] = UserDefaults.standard.array(forKey: "SearchHistory") as? [String] ?? []
    @State private var showHistory: Bool = false
    @State private var manageHistory: Bool = false
    
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search Location", text: $searchQuery)
                    .frame(height: 15)
                    .padding()
                    .submitLabel(.search)
                    .onChange(of: searchQuery) {
                        showHistory = !searchQuery.isEmpty
                    }
                    .onSubmit {
                        onSearchSubmit()
                    }
                    .focused($isSearchFocused)
            }
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .shadow(color: .gray, radius: 15, x: 0, y: 0) // Add shadow here
            .padding(.horizontal)

            
            Spacer()
            
            if showHistory {
                List {
                    HStack {
                        Text("YOUR RECENT SEARCHES")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                            .lineLimit(0)
                        
                        Spacer()
                        if manageHistory {
                            Button("Done") {
                                manageHistory = false
                            }
                            .font(.system(size: 15))
                            .foregroundStyle(Color.accentColor)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        } else {
                            
                            Button("Manage") {
                                manageHistory = true
                            }
                            .font(.system(size: 15))
                            .foregroundStyle(Color.accentColor)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    
                    ForEach(searchHistory, id: \.self) { item in
                        HStack {
                            if manageHistory {
                                Button(action: {
                                    if let index = searchHistory.firstIndex(of: item) {
                                        searchHistory.remove(at: index)
                                        UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                }
                            } else {
                                Image(systemName: "clock.arrow.circlepath")
                                    .foregroundStyle(.gray)
                            }
                            
                            Button(action: {
                                self.searchQuery = item
                                onSearchSubmit()
                            }) {
                                Text(item)
                                    .font(.system(size: 15,weight: .semibold))
                                    .foregroundStyle(Color.black)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.right").foregroundStyle(Color.accentColor)
                        }
                    }
                }
                .listStyle(.plain)
            } else if let location = locationViewModel.location,
               let latitude = location.latitude,
               let longitude = location.longitude {
                   
                VStack {

                    
                    if let weather = weatherViewModel.weather {
                        WeatherView(weather: weather)
                    }
                    
                    if !forecastViewModel.Forecast.isEmpty {
//                        VStack {
//                            ForEach(forecastViewModel.Forecast) { forecast in
//                                ForecastRow(forecast: forecast)
//                            }
//                        }
                    }
                }
                .onAppear {
                    fetchWeatherData(latitude: latitude, longitude: longitude)
                    fetchForecastData(latitude: latitude, longitude: longitude)
                }
            }
        }
    }
    
    private func onSearchSubmit() {
        self.showHistory = false
        
        fetchLocationData(searchQuery: searchQuery)
        if !searchHistory.contains(searchQuery) {
            searchHistory.append(searchQuery)
            UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
        }
        showHistory = false
    }
    
    private func fetchLocationData(searchQuery: String) {
        locationViewModel.fetchLocation(searchQuery: searchQuery)
    }
    
    private func fetchWeatherData(latitude: Double, longitude: Double) {
        weatherViewModel.fetchWeatherData(latitude: latitude, longitude: longitude)
    }
    
    private func fetchForecastData(latitude: Double, longitude: Double) {
        forecastViewModel.fetchForecast(latitude: latitude, longitude: longitude)
    }
}

#Preview {
    ContentView()
}
