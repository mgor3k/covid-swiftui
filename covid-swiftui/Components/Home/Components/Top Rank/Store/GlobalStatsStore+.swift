//
//  Created by Maciej Gorecki on 26/12/2020.
//

import Foundation
import Combine

extension GlobalStatsStore {
    static let `default` = GlobalStatsStore(
        provider: SummaryProvider(session: URLSession.shared)
    )
    
    static let mock = GlobalStatsStore(
        provider: MockProvider()
    )
}

private extension GlobalStatsStore {
    struct MockProvider: SummaryProviding {
        func summary() -> AnyPublisher<[SummaryCountry], Error> {
            Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
