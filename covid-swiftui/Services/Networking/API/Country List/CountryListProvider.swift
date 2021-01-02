//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

protocol CountryListProviding {
    func getCountryList() -> AnyPublisher<[Country], Error>
}

struct CountryListProvider: CountryListProviding {
    let network: Networking
    
    func getCountryList() -> AnyPublisher<[Country], Error> {
        network
            .loadData(from: .countries)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
