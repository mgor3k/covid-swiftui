//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

extension CountryPickerViewModel {
    static func mock(
        countries: [Country],
        selectedCountry: Country
    ) -> CountryPickerViewModel {
        .init(
            provider: MockProvider(countries: countries),
            selectedCountry: .constant(selectedCountry)
        )
    }
}

extension CountryPickerViewModel {
    struct MockProvider: CountryListProviding {
        let countries: [Country]
        
        init(countries: [Country]) {
            self.countries = countries
        }
        
        func getCountryList() -> AnyPublisher<[Country], Error> {
            Just(countries)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
