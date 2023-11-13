//
//  WeatherViewModelTests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
import Combine
@testable import roomvu_challenge_task

final class WeatherViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    func testFetchWeatherData() {
        let viewModel = WeatherViewModel()
        let expectation = XCTestExpectation(description: "Fetch weather data")

        viewModel.fetchWeatherData(latitude: 0, longitude: 0)

        viewModel.$weather
            .sink { weather in
                if weather != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10)
    }
    
}
