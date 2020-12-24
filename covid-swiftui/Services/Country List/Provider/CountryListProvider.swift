//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

struct CountryListProvider: CountryListProviding {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func getCountryList() -> AnyPublisher<[Country], Error> {
        session
            .dataTaskPublisher(forEndpoint: .countries)
            .map(\.data)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
