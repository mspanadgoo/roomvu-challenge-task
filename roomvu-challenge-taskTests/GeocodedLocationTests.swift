//
//  GeocodedLocationTests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
@testable import roomvu_challenge_task

final class GeocodedLocationTests: XCTestCase {

    func testDecodeGeocodedLocation() {
        let json = """
        {
            "name": "Tehran",
            "lat": 37.7749,
            "lon": -122.4194,
            "country": "Iran",
            "state": "Tehran"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        do {
            let location = try decoder.decode(GeocodedLocation.self, from: json)
            XCTAssertEqual(location.name, "Tehran")
            XCTAssertEqual(location.lat, 37.7749)
            XCTAssertEqual(location.lon, -122.4194)
            XCTAssertEqual(location.country, "Iran")
            XCTAssertEqual(location.state, "Tehran")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

}
