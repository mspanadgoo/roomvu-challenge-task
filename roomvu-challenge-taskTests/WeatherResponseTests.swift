//
//  WeatherResponseTests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
@testable import roomvu_challenge_task

final class WeatherResponseTests: XCTestCase {

    func testDecodeWeatherResponse() {
        let json = """
        {
            "coord": {"lon": 139,"lat": 35},
            "weather": [{"id": 800,"main": "Clear","description": "clear sky","icon": "01n"}],
            "base": "stations",
            "main": {"temp": 281.52,"feels_like": 278.99,"temp_min": 280.15,"temp_max": 283.71,"pressure": 1016,"humidity": 93},
            "visibility": 10000,
            "wind": {"speed": 0.47,"deg": 107},
            "clouds": {"all": 2},
            "dt": 1560350192,
            "sys": {"type": 3,"id": 2019346,"message": 0.0065,"country": "IR","sunrise": 1560281377,"sunset": 1560333478},
            "timezone": 32400,
            "id": 1851632,
            "name": "Tehran",
            "cod": 200
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        do {
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: json)
            XCTAssertNotNil(weatherResponse, "WeatherResponse should not be nil")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

}
