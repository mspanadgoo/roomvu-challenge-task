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
    
    var body: some View {
        VStack {
            TextField("Search Location", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Search") {
                locationViewModel.fetchLocation(searchQuery: searchQuery)
            }
            .padding()
            
            if let location = locationViewModel.location {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
                
                Button("Fetch Weather") {
                    fetchWeatherData(latitude: location.latitude, longitude: location.longitude)
                }
                .padding()
            }
            
            if let error = locationViewModel.error {
                Text("Error: \(error.localizedDescription)")
            }
        }
        .padding()
    }
    
    private func fetchWeatherData(latitude: Double, longitude: Double) {
        forecastViewModel.fetchForecast(latitude: latitude, longitude: longitude)
        
        // Handle the fetched weather data in the forecastViewModel
        // You can access the weather data from forecastViewModel.forecast property
        // You can also handle any errors from forecastViewModel.error property
    }
}

#Preview {
    ContentView()
}
