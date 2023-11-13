//
//  ForecastResponseTests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
@testable import roomvu_challenge_task

final class ForecastResponseTests: XCTestCase {

    func testDecodeForecastResponse() {
            let json = """
            {
                "cod": "200",
                "message": 0,
                "cnt": 40,
                "list": [],
                "city": {
                    "id": 2643743,
                    "name": "Tehran",
                    "coord": {
                        "lat": 51.5073,
                        "lon": -0.1277
                    },
                    "country": "IR",
                    "population": 1000000,
                    "timezone": 3600,
                    "sunrise": 1485762037,
                    "sunset": 1485794875
                }
            }
            """.data(using: .utf8)!

            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ForecastResponse.self, from: json)
                XCTAssertEqual(response.cod, "200")
                XCTAssertEqual(response.message, 0)
                XCTAssertEqual(response.cnt, 40)
                XCTAssertEqual(response.city.name, "Tehran")
            } catch {
                XCTFail("Decoding failed: \(error)")
            }
        }

}
