//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

struct NetworkService {
    private let baseURL = "https://api.covid19api.com"
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}

extension NetworkService: Networking {
    func fetchLastStats(forCountry country: String) -> AnyPublisher<CovidStats, Error> {
        session.dataTaskPublisher(for: resolveURL(forCountry: country))
            .map(\.data)
            .decode(type: [CovidStats].self, decoder: JSONDecoder())
            .compactMap { $0.last }
            .eraseToAnyPublisher()
    }
}

private extension NetworkService {
    func resolveURL(forCountry country: String) -> URL {
        URL(string: baseURL + "/total/country/" + country)!
    }
}
