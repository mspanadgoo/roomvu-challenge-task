//
//  ForecastsViewModel.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

class ForecastsViewModel: ObservableObject {
    @Published var forecasts: [Forecast] = []
    @Published var error: Error?
    
    private let forecastsAPI: ForecastsAPIServices
    private var cancellables = Set<AnyCancellable>()
    
    init(forecastsAPI: ForecastsAPIServices = ForecastsAPIImp()) {
        self.forecastsAPI = forecastsAPI
    }
    
    func fetchForecasts(latitude: Double, longitude: Double) {
        forecastsAPI.fetchForecastsData(longitude: longitude, latitude: latitude)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            } receiveValue: { forecasts in
                self.forecasts = forecasts
            }
            .store(in: &cancellables)
    }
}
