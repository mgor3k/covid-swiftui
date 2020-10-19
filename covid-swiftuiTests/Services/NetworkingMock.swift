//
//  Created by Maciej Gorecki on 19/10/2020.
//

import Foundation
import Combine
@testable import covid_swiftui

struct NetworkingMock: Networking {
    enum InputTiming {
        case immediately, delayed(TimeInterval)
    }
    
    let stats: CovidStats
    let error: Error?
    let inputTiming: InputTiming
    
    init(
        stats: CovidStats = .empty,
        error: URLError? = nil,
        inputTiming: InputTiming = .immediately) {
        self.stats = stats
        self.error = error
        self.inputTiming = inputTiming
    }
    
    func fetchLastStats(forCountry country: String) -> AnyPublisher<CovidStats, Error> {
        let publisher = PassthroughSubject<CovidStats, Error>()
        
        if let error = error {
            publisher.send(completion: .failure(error))
        }
        
        switch inputTiming {
        case .immediately:
            publisher.send(stats)
        case .delayed(let interval):
            DispatchQueue.global().asyncAfter(deadline: .now() + interval) {
                publisher.send(stats)
            }
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
