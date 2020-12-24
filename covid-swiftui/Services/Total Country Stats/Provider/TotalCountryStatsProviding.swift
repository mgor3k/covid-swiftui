//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Combine

protocol TotalCountryStatsProviding {
    // TODO: Make enum instead of string
    func totalStats(for country: String) -> AnyPublisher<TotalCountryStats, Error>
}
