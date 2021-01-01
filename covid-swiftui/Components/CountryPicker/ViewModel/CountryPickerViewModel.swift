//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import SwiftUI
import Combine

class CountryPickerViewModel: LoadableObject {
    typealias Output = [Country]
    
    private let provider: CountryListProviding
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var state: LoadingState<[Country]> = .idle
    @Published var searchText = ""
    @Binding var selectedCountry: Country
    
    private var fetchedCountries: [Country] = []
    
    init(
        provider: CountryListProviding = CountryListProvider(session: .shared),
        selectedCountry: Binding<Country>) {
        self.provider = provider
        self._selectedCountry = selectedCountry
        
        $searchText
            .dropFirst()
            .sink { [weak self] searchText in
                self?.updateState(for: searchText)
            }
            .store(in: &subscriptions)
    }
}

extension CountryPickerViewModel {
    func load() {
        state = .loading
        
        provider
            .getCountryList()
            .print()
            .receive(on: DispatchQueue.main)
            .map { $0.sorted(by: { $0.country < $1.country }) }
            .sink { [weak self] result in
                self?.updateState(for: result)
            }
            .store(in: &subscriptions)
    }
}

private extension CountryPickerViewModel {
    func updateState(for result: Result<[Country], Error>) {
        switch result {
        case .success(let countries):
            fetchedCountries = countries
            state = .loaded(countries)
        case .failure(let error):
            state = .failed(error)
        }
    }
    
    func updateState(for searchText: String) {
        let filtered = fetchedCountries.filter { searchText.isEmpty ? true : $0.country.contains(searchText) }
        state = .loaded(filtered)
    }
}
