//
//  ForecastAPITests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
import Combine
@testable import roomvu_challenge_task

final class ForecastAPITests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func testFetchForecastData() {
        let forecastAPI = ForecastAPIImp()
        let expectation = XCTestExpectation(description: "Fetch forecast data")

        forecastAPI.fetchForecastData(longitude: -0.1276474, latitude: 51.5073219)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Fetch forecast data failed with error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { forecasts in
                XCTAssertNotNil(forecasts, "Forecasts data should not be nil")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 20)
    }

}
