//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

extension CountryPickerStore {
    static let `default` = CountryPickerStore(
        provider: CountryListProvider(session: URLSession.shared)
    )
    
    static let mock = CountryPickerStore(
        provider: MockProvider()
    )
}

extension CountryPickerStore {
    struct MockProvider: CountryListProviding {
        var countries: [Country] = [
            .init(country: "Country1", slug: "1"),
            .init(country: "Country2", slug: "2")
        ]
        
        func getCountryList() -> AnyPublisher<[Country], Error> {
            Just(countries)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
