//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import Combine

extension CountryPickerViewModel {
    static func mock(
        countries: [Country],
        selectedCountry: Country,
        isError: Bool = false
    ) -> CountryPickerViewModel {
        .init(
            provider: MockProvider(countries: countries, isError: isError),
            selectedCountry: .constant(selectedCountry)
        )
    }
}

extension CountryPickerViewModel {
    struct MockProvider: CountryListProviding {
        let countries: [Country]
        let isError: Bool
        
        init(countries: [Country], isError: Bool = false) {
            self.countries = countries
            self.isError = isError
        }
        
        func getCountryList() -> AnyPublisher<[Country], Error> {
            guard !isError else {
                struct SomeError: LocalizedError {
                    var errorDescription: String? { "Some error description" }
                }
                return Fail(outputType: [Country].self, failure: SomeError())
                    .eraseToAnyPublisher()
            }
            
            return Just(countries)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
