//
//  WeatherAPI.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

protocol WeatherAPIServices {
    func fetchWeatherData(longitude: Double, latitude: Double) -> AnyPublisher<Weather, WeatherAPIServicesError>
}

enum WeatherAPIServicesError: Error {
    case generalError
}

class WeatherAPIImp: WeatherAPIServices {
    private let baseURL = APP_API.baseURL.api
    private let apiKey = APP_API.apiKey
    private let weatherEndpoint = APP_API.WeatherEndpoints.weather
    private let units = APP_API.Unit.metric
    
    func fetchWeatherData(longitude: Double, latitude: Double) -> AnyPublisher<Weather, WeatherAPIServicesError> {
        let urlString = "\(baseURL)/\(weatherEndpoint)?lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: WeatherAPIServicesError.generalError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)

                guard let weatherDetail = weatherResponse.weather.first else {
                    throw WeatherAPIServicesError.generalError
                }
                
                let weather = Weather(
                    id: weatherDetail.id,
                    main: weatherDetail.main,
                    description: weatherDetail.main,
                    icon: weatherDetail.icon,
                    temperature: weatherResponse.main.temp,
                    humidity: weatherResponse.main.humidity,
                    windSpeed: weatherResponse.wind.speed,
                    location: weatherResponse.name,
                    minTemp: weatherResponse.main.tempMin,
                    maxTemp: weatherResponse.main.tempMax,
                    feelsLike: weatherResponse.main.feelsLike,
                    dateTime: weatherResponse.dt,
                    pressure: weatherResponse.main.pressure
                )
                return weather
            }
            .mapError { error in
                print("Weather API Error: \(error)")
                return WeatherAPIServicesError.generalError
            }
            .eraseToAnyPublisher()
    }
}
