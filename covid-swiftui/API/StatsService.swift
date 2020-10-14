//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

protocol StatsFetching {
    func fetchStats(forCountry country: String) -> AnyPublisher<[CountryStats], Error>
}

enum StatsNetworkError: Error {
    case invalidURL
}

struct StatsService {
    private let baseURL = "https://api.covid19api.com"
}

extension StatsService: StatsFetching {
    func fetchStats(forCountry country: String) -> AnyPublisher<[CountryStats], Error> {
        guard let url = URL(string: baseURL + "/total/country/" + country) else {
            return Fail(error: StatsNetworkError.invalidURL).eraseToAnyPublisher()
        }
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CountryStats].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
