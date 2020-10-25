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

// TODO: Make some endpoint model?
extension NetworkService: Networking {
    func fetchLastStats(forCountry country: String) -> AnyPublisher<CovidStats, Error> {
        session.dataTaskPublisher(
            for: URL(string: baseURL + "/total/country/" + country)!
        )
        .map(\.data)
        .decode(type: [CovidStats].self, decoder: JSONDecoder())
        .compactMap { $0.last }
        .eraseToAnyPublisher()
    }
    
    func fetchCountries() -> AnyPublisher<[Country], Error> {
        session.dataTaskPublisher(
            for: URL(string: baseURL + "/countries")!
        )
        .map(\.data)
        .decode(type: [Country].self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
