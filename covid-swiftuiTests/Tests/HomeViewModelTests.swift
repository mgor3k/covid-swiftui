//
//  Created by Maciej Gorecki on 19/10/2020.
//

import XCTest
import Combine
@testable import covid_swiftui

class HomeViewModelTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()
    
    func test_init() {
        let network = NetworkingMock()
        let sut = HomeViewModel(network: network)
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.stats, CovidStats.empty)
    }
    
    func test_startFetching() {
        let stats = CovidStats(confirmed: 50, deaths: 50, recovered: 50, active: 50)
        let network = NetworkingMock(stats: stats)
        let sut = HomeViewModel(network: network)
        
        var result: CovidStats?
        
        let exp = expectation(description: "waiting for result")
        
        sut.$stats
            .dropFirst()
            .sink(receiveValue: {
                result = $0
                exp.fulfill()
            })
            .store(in: &subscriptions)
        
        sut.startFetching()
        
        waitForExpectations(timeout: 0.5)
        
        XCTAssertEqual(result, stats)
    }
}
