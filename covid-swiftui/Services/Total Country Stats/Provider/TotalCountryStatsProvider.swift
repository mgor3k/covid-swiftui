//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

struct TotalCountryStatsProvider: TotalCountryStatsProviding {
    let session: URLSession
    
    func totalStats(
        for country: String
    ) -> AnyPublisher<CovidStats, Error> {
        session.dataTaskPublisher(
            forEndpoint: .totalStats(country: country)
        )
        .map(\.data)
        .decode(type: [CovidStats].self, decoder: JSONDecoder())
        .compactMap { $0.last }
        .eraseToAnyPublisher()
    }
}