//
//  Created by Maciej Gorecki on 26/12/2020.
//

import Foundation
import Combine

protocol SummaryProviding {
    func summary() -> AnyPublisher<[SummaryCountry], Error>
}

struct SummaryProvider: SummaryProviding {
    let network: Networking
    
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
