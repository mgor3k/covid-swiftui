//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Combine

class CoreDataCache {
    
}

extension CoreDataCache: StatsLoading {
    // TODO: Temporary
    func loadStats(forCountry country: String) -> AnyPublisher<[CountryStats], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}

extension CoreDataCache: StatsStoring {
    // TODO: Temporary
    func storeStats(_ stats: [CountryStats]) -> AnyPublisher<Void, Error> {
        Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
