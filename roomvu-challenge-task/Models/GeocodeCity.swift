//
//  GeocodeCity.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import Foundation
import CoreLocation

struct GeocodCity: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
