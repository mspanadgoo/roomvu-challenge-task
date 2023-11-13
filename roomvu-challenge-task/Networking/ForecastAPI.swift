//
//  ForecastAPI.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

protocol ForecastAPIServices {
    func fetchForecastData(longitude: Double, latitude: Double) -> AnyPublisher<[Forecast], ForecastAPIServicesError>
}

enum ForecastAPIServicesError: Error {
    case generalError
}

class ForecastAPIImp: ForecastAPIServices {
    private let baseURL = APP_API.baseURL.api
    private let apiKey = APP_API.apiKey
    private let forecastEndpoint = APP_API.WeatherEndpoints.forecast
    private let units = APP_API.Unit.metric

    func fetchForecastData(longitude: Double, latitude: Double) -> AnyPublisher<[Forecast], ForecastAPIServicesError> {
        let urlString = "\(baseURL)/\(forecastEndpoint)?lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(apiKey)"
        
        print("Forecast url: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            return Fail(error: ForecastAPIServicesError.generalError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                print("Forecast Data: ")
                print(String(data: data, encoding: .utf8) ?? "")
                let decoder = JSONDecoder()
                let forecastResponse = try decoder.decode(ForecastResponse.self, from: data)

                return forecastResponse.list
            }
            .mapError { error in
                print("Weather API Error: \(error)")
                return ForecastAPIServicesError.generalError
            }
            .eraseToAnyPublisher()
    }
}
