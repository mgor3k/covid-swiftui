//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import SwiftUI
import Combine

class CountryPickerViewModel: ObservableObject {
    private let provider: CountryListProviding
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private var countries: [Country] = []
    
    @Published var searchText = ""
    @Binding var selectedCountry: Country
    
    var filteredCountries: [Country] {
        countries.filter { searchText.isEmpty ? true : $0.country.contains(searchText) }
    }
    
    init(
        provider: CountryListProviding = CountryListProvider(session: .shared),
        selectedCountry: Binding<Country>) {
        self.provider = provider
        self._selectedCountry = selectedCountry
    }
}

extension CountryPickerViewModel {
    func fetchList() {
        provider
            .getCountryList()
            .print()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .map { $0.sorted(by: { $0.country < $1.country }) }
            .assign(to: \.countries, on: self)
            .store(in: &subscriptions)
    }
}
