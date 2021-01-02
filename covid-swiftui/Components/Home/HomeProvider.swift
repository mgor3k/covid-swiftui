//
//  Created by Maciej Gorecki on 02/01/2021.
//

import Foundation
import Combine

struct HomeProvider: TotalCountryStatsProviding, SummaryProviding {
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
    
    func summary() -> AnyPublisher<[SummaryCountry], Error> {
        network
            .loadData(from: .summary)
            .decode(type: SummaryResponse.self, decoder: JSONDecoder())
            .map { summary in
                let countries = summary.countries
                let sortedByConfirmed = countries.sorted(by: { $0.totalConfirmed > $1.totalConfirmed })
                let first10 = sortedByConfirmed.prefix(10)
                return Array(first10)
            }
            .eraseToAnyPublisher()
    }
}
