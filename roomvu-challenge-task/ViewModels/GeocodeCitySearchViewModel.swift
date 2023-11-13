//
//  GeocodeCitySearchViewModel.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import CoreLocation
import SwiftUI
import Combine

class GeocodeCitySearchViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var city: GeocodCity?
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $cityName
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] in self?.searchCity($0) }
    }
    
    private func searchCity(_ query: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(query) { [weak self] placemarks, error in
            if let error = error {
                print("Geocoding Error: \(error)")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                self?.city = GeocodCity(name: query, coordinate: location.coordinate)
            }
        }
    }
}
