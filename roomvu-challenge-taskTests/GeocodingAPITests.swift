//
//  GeocodingAPITests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
import Combine
@testable import roomvu_challenge_task

final class GeocodingAPITests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func testFetchLocationData() {
        let geocodingAPI = GeocodingAPIImp()
        let expectation = XCTestExpectation(description: "Fetch location data")

        geocodingAPI.fetchLocationData(searchQuery: "Tehran")
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Fetch location data failed with error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { location in
                XCTAssertNotNil(location, "Location data should not be nil")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10)
    }

}
