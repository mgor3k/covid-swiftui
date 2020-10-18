//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Combine

protocol StatsLoading {
    func loadStats(forCountry country: String) -> AnyPublisher<[CountryStats], Error>
}
