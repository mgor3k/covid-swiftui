//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

protocol TotalCountryStatsProviding {
    func totalStats(for country: Country) -> AnyPublisher<TotalCountryStats, Error>
}
