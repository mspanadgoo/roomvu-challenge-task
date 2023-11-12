//
//  WeatherViewModel.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var error: Error?
    
    private let weatherAPI: WeatherAPIServices
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherAPI: WeatherAPIServices = WeatherAPIImp()) {
        self.weatherAPI = weatherAPI
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        weatherAPI.fetchWeatherData(longitude: longitude, latitude: latitude)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            } receiveValue: { weather in
                self.weather = weather
            }
            .store(in: &cancellables)
    }
}
