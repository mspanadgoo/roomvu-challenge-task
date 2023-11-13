//
//  Weather.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation

struct Weather: Codable {
    let id: Int?
    let main: String
    let description: String
    let icon: String
    let temperature: Double?
    let humidity: Int?
    let windSpeed: Double?
    let location: String?
    let minTemp: Double?
    let maxTemp: Double?
    let feelsLike: Double?
    let dateTime: TimeInterval?
    let pressure: Int?
}
