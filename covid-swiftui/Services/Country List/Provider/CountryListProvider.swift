//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

struct CountryListProvider: CountryListProviding {
    let session: URLSession
    
    func getCountryList() -> AnyPublisher<[Country], Error> {
        session
            .dataTaskPublisher(forEndpoint: .countries)
            .map(\.data)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
