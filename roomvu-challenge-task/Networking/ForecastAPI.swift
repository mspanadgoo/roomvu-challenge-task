//
//  ForecastsAPI.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

protocol ForecastsAPIServices {
    func fetchForecastData(longitude: Double, latitude: Double) -> AnyPublisher<ForecastResponse, ForecastsAPIServicesError>
}

enum ForecastsAPIServicesError: Error {
    case generalError
}

class ForecastsAPIImp: ForecastsAPIServices {
    private let baseURL = APP_API.baseURL.api
    private let apiKey = APP_API.apiKey
    private let hourlyForecastEndpoint = APP_API.WeatherEndpoints.forecast
    
    func fetchForecastsData(longitude: Double, latitude: Double) -> AnyPublisher<[Forecast], ForecastsAPIServicesError> {
        let urlString = "\(baseURL)/\(hourlyForecastEndpoint)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        print("forecasts url: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            return Fail(error: ForecastsAPIServicesError.generalError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in ForecastsAPIServicesError.generalError }
            .flatMap { data, _ -> AnyPublisher<[Forecast], ForecastsAPIServicesError> in
                print("Forecasts Data: ")
                print(String(data: data, encoding: .utf8) ?? "")
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                return Just(data)
                    .decode(type: ForecastResponse.self, decoder: decoder)
                    .map { forecastResponse in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let list = forecastResponse.list
                        return list!.compactMap { forecastData in
                            return Forecast(id: forecastData.weather.id, dt: forecastData.dt, main: forecastData.main, weather: forecastData.weather, clouds: forecastData.clouds, wind: forecastData.wind, visibility: forecastData.visibility, pop: forecastData.pop, rain: forecastData.rain, sys: forecastData.sys, dtTxt: forecastData.dtTxt)
                        }
                    }
                    .mapError { _ in ForecastsAPIServicesError.generalError }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
