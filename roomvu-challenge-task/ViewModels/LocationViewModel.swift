//
//  LocationViewModel.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation
import Combine

class LocationViewModel: ObservableObject {
    @Published var location: Location?
    @Published var error: IdentifiableError?

    private let geocodingAPI: GeocodingAPIServices
    private var cancellables = Set<AnyCancellable>()
    
    init(geocodingAPI: GeocodingAPIServices = GeocodingAPIImp()) {
        self.geocodingAPI = geocodingAPI
    }
    
    func fetchLocation(searchQuery: String) {
        geocodingAPI.fetchLocationData(searchQuery: searchQuery)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = IdentifiableError(error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.error = nil
                    }
                case .finished:
                    break
                }
            } receiveValue: { geocodedLocation in
                self.location = Location(geocodedLocation: geocodedLocation)
            }
            .store(in: &cancellables)
    }
}
