//
//  ForecastViewModelTests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
import Combine
@testable import roomvu_challenge_task

final class ForecastViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    func testFetchForecastData() {
        let viewModel = ForecastViewModel()
        let expectation = XCTestExpectation(description: "Fetch forecast data")

        viewModel.fetchForecast(latitude: -0.1276474, longitude: 51.5073219)

        viewModel.$forecasts
            .sink { forecasts in
                if !forecasts.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 20)
    }
    
}
