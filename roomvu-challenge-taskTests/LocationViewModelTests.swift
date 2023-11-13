//
//  LocationViewModelTests.swift
//  roomvu-challenge-taskTests
//
//  Created by Mohammad Sadegh Panadgoo on 8/22/1402 AP.
//

import XCTest
import Combine
@testable import roomvu_challenge_task


final class LocationViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

        func testFetchLocation() {
            let viewModel = LocationViewModel()
            let expectation = XCTestExpectation(description: "Fetch location data")

            viewModel.fetchLocation(searchQuery: "Seattle")

            viewModel.$location
                .sink { location in
                    if location != nil {
                        expectation.fulfill()
                    }
                }
                .store(in: &cancellables)

            wait(for: [expectation], timeout: 10)
        }

}
