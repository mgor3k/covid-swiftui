//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

struct TotalCountryStatsProvider: TotalCountryStatsProviding {
    let session: URLSession
    
    func totalStats(
        for country: String
    ) -> AnyPublisher<TotalCountryStats, Error> {
        session.dataTaskPublisher(
            forEndpoint: .totalStats(country: country)
        )
        .print()
        .map(\.data)
        .decode(type: [TotalCountryStats].self, decoder: JSONDecoder())
        .compactMap { $0.last }
        .replaceEmpty(with: .empty)
        .eraseToAnyPublisher()
    }
}
