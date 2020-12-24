//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

extension HomeStore {
    static let `default` = HomeStore(
        provider: TotalCountryStatsProvider(session: URLSession.shared)
    )
    
    static let mock = HomeStore(
        provider: MockProvider()
    )
}

extension HomeStore {
    struct MockProvider: TotalCountryStatsProviding {
        func totalStats(for country: String) -> AnyPublisher<CovidStats, Error> {
            Just(
                .init(confirmed: 1, deaths: 2, recovered: 3, active: 4)
            )
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }
}
