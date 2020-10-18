//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Combine

typealias StatsCache = StatsLoading & StatsStoring

protocol StatsStoring {
    func storeStats(_ stats: [CountryStats]) -> AnyPublisher<Void, Error>
}
