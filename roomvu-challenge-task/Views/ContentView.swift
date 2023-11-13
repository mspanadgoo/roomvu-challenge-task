//
//  ContentView.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var forecastViewModel = ForecastViewModel()
//    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var citySearchViewModel = GeocodeCitySearchViewModel()
    
    @EnvironmentObject var searchHistory: SearchHistory

    @State private var searchQuery: String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    @State private var showResult: Bool = false
    @State private var showHistory: Bool = false
    @State private var manageHistory: Bool = false
    @State private var errorMessage: IdentifiableError?

    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.accentColor)
                TextField("Search Location", text: $searchQuery)
                    .frame(height: 15)
                    .padding()
                    .submitLabel(.search)
                    .onChange(of: searchQuery) {
                        showHistory = !searchHistory.items.isEmpty
                    }
                    .onSubmit {
                        onSearchSubmit()
                    }
                    .focused($isSearchFocused)
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal)
            
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
                    
                    ForEach(searchHistory.items, id: \.self) { item in
                        HStack {
                            if manageHistory {
                                Button(action: {
                                    if let index = searchHistory.items.firstIndex(of: item) {
                                        searchHistory.items.remove(at: index)
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
                                if !manageHistory {
                                    self.searchQuery = item
                                    onSearchSubmit()
                                }
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
            } else if showResult {
                    PageView(views: [AnyView(TodayView(weather: $weatherViewModel.weather, forecasts: $forecastViewModel.forecasts)),
                                     AnyView(SecondPageView(weather: $weatherViewModel.weather, forecasts: $forecastViewModel.forecasts))])
            } else {
                Text("Search a location to get weather information.")
                    .foregroundStyle(.gray)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .onAppear {
            if !searchHistory.items.isEmpty {
                showHistory = true
            }
            
            isSearchFocused = true
        }
        .onReceive(citySearchViewModel.$city) { city in
            if let city = city {
                fetchData(latitude: city.coordinate.latitude, longitude: city.coordinate.longitude)
                showHistory = false
                showResult = true
            }
        }
        .onReceive(weatherViewModel.$error) { error in
            if let error = error {
                errorMessage = IdentifiableError(error)
            }
        }
        .onReceive(forecastViewModel.$error) { error in
            if let error = error {
                errorMessage = IdentifiableError(error)
            }
        }
//        .onReceive(locationViewModel.$error) { error in
//            if let error = error {
//                errorMessage = IdentifiableError(error)
//            }
//        }
        .alert(item: $errorMessage) { error in
            Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
        }
        
        Spacer()
    }
    
    private func onSearchSubmit() {
//        fetchLocationData(searchQuery: searchQuery)
        citySearchViewModel.cityName = searchQuery
        
        if !searchHistory.items.contains(searchQuery) {
            searchHistory.items.append(searchQuery)
        }
    }
    
//    private func fetchLocationData(searchQuery: String) {
//        locationViewModel.fetchLocation(searchQuery: searchQuery)

//    }
    
    private func fetchData(latitude: Double, longitude: Double) {
        weatherViewModel.fetchWeatherData(latitude: latitude, longitude: longitude)
        forecastViewModel.fetchForecast(latitude: latitude, longitude: longitude)
    }
}







