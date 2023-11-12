//
//  ForecastViewModel.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

class ForecastViewModel: ObservableObject {
    @Published var Forecast: [Forecast] = []
    @Published var error: Error?
    
    private let ForecastAPI: ForecastAPIServices
    private var cancellables = Set<AnyCancellable>()
    
    init(ForecastAPI: ForecastAPIServices = ForecastAPIImp()) {
        self.ForecastAPI = ForecastAPI
    }
    
    func fetchForecast(latitude: Double, longitude: Double) {
        ForecastAPI.fetchForecastData(longitude: longitude, latitude: latitude)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            } receiveValue: { Forecast in
                self.Forecast = Forecast
            }
            .store(in: &cancellables)
    }
}
