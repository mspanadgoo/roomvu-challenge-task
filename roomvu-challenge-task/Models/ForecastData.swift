//
//  ForecastData.swift
//  roomvu-challenge-task
//
//  Created by Mohammad Sadegh Panadgoo on 8/20/1402 AP.
//

import Foundation

struct ForecastData: Codable {
    let dtTxt: String
    let weather: [WeatherData]
    let main: Main
}
