//
//  Created by Maciej Gorecki on 02/01/2021.
//

import Foundation
import Combine

struct CountryPickerProvider: CountryListProviding {
    let network: Networking
    
    func getCountryList() -> AnyPublisher<[Country], Error> {
        network
            .loadData(from: .countries)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
