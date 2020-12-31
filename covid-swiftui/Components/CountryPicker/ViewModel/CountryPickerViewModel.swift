//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation
import SwiftUI
import Combine

class CountryPickerViewModel: ObservableObject {
    private let provider: CountryListProviding
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published private(set) var state: State = .idle
    @Published var searchText = ""
    @Binding var selectedCountry: Country
    
    private var fetchedCountries: [Country] = []
    
    init(
        provider: CountryListProviding = CountryListProvider(session: .shared),
        selectedCountry: Binding<Country>) {
        self.provider = provider
        self._selectedCountry = selectedCountry
        
        setSearchSubscription()
    }
}

extension CountryPickerViewModel {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([Country])
    }
    
    func fetchList() {
        state = .loading
        
        provider
            .getCountryList()
            .print()
            .receive(on: DispatchQueue.main)
            .map { $0.sorted(by: { $0.country < $1.country }) }
            .sink { [weak self] result in
                switch result {
                case .success(let countries):
                    self?.fetchedCountries = countries
                    self?.state = .loaded(countries)
                case .failure(let error):
                    self?.state = .failed(error)
                }
            }
            .store(in: &subscriptions)
    }
}

private extension CountryPickerViewModel {
    func setSearchSubscription() {
        $searchText
            .dropFirst()
            .sink { [unowned self] searchText in
                let list = fetchedCountries.filter { searchText.isEmpty ? true : $0.country.contains(searchText) }
                state = .loaded(list)
            }
            .store(in: &subscriptions)
    }
}
