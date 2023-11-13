//
//  Location.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation

struct Location: Equatable {
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let state: String?
    
    init(geocodedLocation: GeocodedLocation) {
        self.name = geocodedLocation.name
        self.latitude = geocodedLocation.lat
        self.longitude = geocodedLocation.lon
        self.country = geocodedLocation.country
        self.state = geocodedLocation.state
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
