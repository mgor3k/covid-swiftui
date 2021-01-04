//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

typealias HomeViewModelProvider = TotalCountryStatsProviding & SummaryProviding

class HomeViewModel: ObservableObject {
    private let provider: HomeViewModelProvider
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var selectedCountry: Country
    @Published var topCountries: [SummaryCountry] = []
    @Published var stats: TotalCountryStats = .empty
    
    @Published var isStatsLoading = false
    @Published var isTopCountriesLoading = false
    
    init(provider: HomeViewModelProvider, selectedCountry: Country) {
        self.provider = provider
        self.selectedCountry = selectedCountry
        
        $selectedCountry
            .dropFirst()
            .map { _ in true }
            .assign(to: \.isStatsLoading, on: self)
            .store(in: &subscriptions)
    }
    
    func startFetching() {
        isStatsLoading = true
        
        $selectedCountry
            .flatMap { [unowned self] in
                self.provider.totalStats(for: $0)
            }
            .receive(on: DispatchQueue.main)
            .replaceError(with: .empty)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isStatsLoading = false
            })
            .assign(to: \.stats, on: self)
            .store(in: &subscriptions)
        
        fetchTopRank()
    }
    
    func refreshCountry() {
        let temp = selectedCountry
        self.selectedCountry = temp
    }
    
    func fetchTopRank() {
        isTopCountriesLoading = true
        
        provider
            .summary()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isTopCountriesLoading = false
            })
            .assign(to: \.topCountries, on: self)
            .store(in: &subscriptions)
    }
}
