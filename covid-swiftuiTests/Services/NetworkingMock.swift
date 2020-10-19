//
//  Created by Maciej Gorecki on 19/10/2020.
//

import Foundation
import Combine
@testable import covid_swiftui

struct NetworkingMock: Networking {
    let stats: CovidStats
    let error: Error?
    
    init(
        stats: CovidStats = .empty,
        error: URLError? = nil) {
        self.stats = stats
        self.error = error
    }
    
    func fetchLastStats(forCountry country: String) -> AnyPublisher<CovidStats, Error> {
        let publisher = CurrentValueSubject<CovidStats, Error>(stats)
        
        if let error = error {
            publisher.send(completion: .failure(error))
        }
        
        return publisher.eraseToAnyPublisher()
    }
}
