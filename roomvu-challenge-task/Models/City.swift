//
//  City.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation

struct City: Codable {
    let id: Int?
    let name: String
    let coord: Coord
    let country: String?
    let population, timezone, sunrise, sunset: Int
}
