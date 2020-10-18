//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

struct StatsService {
    private let baseURL = "https://api.covid19api.com"
    private let session: URLSession
    
    // TODO: Factory
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension StatsService: StatsLoading {
    func loadStats(forCountry country: String) -> AnyPublisher<[CountryStats], Error> {
        session.dataTaskPublisher(for: resolveURL(forCountry: country))
            .map(\.data)
            .decode(type: [CountryStats].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

private extension StatsService {
    func resolveURL(forCountry country: String) -> URL {
        guard let url = URL(string: baseURL + "/total/country/" + country) else {
            fatalError("Invalid URL")
        }
        return url
    }
}
