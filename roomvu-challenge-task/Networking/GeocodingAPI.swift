//
//  GeocodingAPI.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

protocol GeocodingAPIServices {
    func fetchLocationData(searchQuery: String) -> AnyPublisher<GeocodedLocation, GeocodingAPIServicesError>
}

enum GeocodingAPIServicesError: Error {
    case generalError
}

class GeocodingAPIImp: GeocodingAPIServices {
    private let baseURL = APP_API.baseURL.api
    private let apiKey = APP_API.apiKey
    private let direct = APP_API.GeocodingEndpoints.direct
    
    func fetchLocationData(searchQuery: String) -> AnyPublisher<GeocodedLocation, GeocodingAPIServicesError> {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)/\(direct)?q=\(encodedQuery)&limit=1&appid=\(apiKey)"

        guard let url = URL(string: urlString) else {
            return Fail(error: GeocodingAPIServicesError.generalError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                let decoder = JSONDecoder()
                let geocodedLocations = try decoder.decode([GeocodedLocation].self, from: data)
                
                if let firstLocation = geocodedLocations.first {
                    return firstLocation
                } else {
                    throw GeocodingAPIServicesError.generalError
                }
            }
            .mapError { error in
                print("Geocoding API Error: \(error)")
                return GeocodingAPIServicesError.generalError
            }
            .eraseToAnyPublisher()
    }
}
