//
//  ForecastResponse.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation

struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [Forecast]
    let city: City
}
