//
//  WeatherAPITests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
import Combine
@testable import roomvu_challenge_task

final class WeatherAPITests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    func testFetchWeatherData() {
        let weatherAPI = WeatherAPIImp()
        let expectation = XCTestExpectation(description: "Fetch weather data")

        weatherAPI.fetchWeatherData(longitude: 0, latitude: 0)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Fetch weather data failed with error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { weather in
                XCTAssertNotNil(weather, "Weather data should not be nil")
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 20)
    }
    
}
