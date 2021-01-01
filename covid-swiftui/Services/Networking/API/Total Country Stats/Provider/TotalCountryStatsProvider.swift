//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

struct TotalCountryStatsProvider: TotalCountryStatsProviding {
    let network: Networking
    
    func totalStats(
        for country: Country
    ) -> AnyPublisher<TotalCountryStats, Error> {
        network
            .loadData(from: .totalStats(country: country.slug))
            .decode(type: [TotalCountryStats].self, decoder: JSONDecoder())
            .compactMap { $0.last }
            .replaceEmpty(with: .empty)
            .eraseToAnyPublisher()
    }
}
