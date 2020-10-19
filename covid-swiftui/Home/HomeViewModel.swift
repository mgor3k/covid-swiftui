//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let fetcher: StatsLoading
    private let cache: StatsCache
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var selectedCountry: String = "Poland"
    @Published var stats: CountryStats?
    @Published var isLoading = false
    
    init(
        fetcher: StatsLoading,
        cache: StatsCache) {
        self.fetcher = fetcher
        self.cache = cache
        
        $selectedCountry
            .dropFirst()
            .map { _ in true }
            .assign(to: \.isLoading, on: self)
            .store(in: &subscriptions)
        
        $selectedCountry
            .dropFirst()
            .flatMap { fetcher.loadStats(forCountry: $0) }
            .compactMap { $0.last }
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .assign(to: \.stats, on: self)
            .store(in: &subscriptions)
        
        $isLoading
            .sink(receiveValue: { value in
                print(value)
            })
            .store(in: &subscriptions)
        
        loadInitialStats()
    }
    
    func loadInitialStats() {
        let selectedCountry = self.selectedCountry
        let fetcher = self.fetcher
        
        isLoading = true
        
        cache
            .loadStats(forCountry: selectedCountry)
            .catch { _ in
                fetcher.loadStats(forCountry: selectedCountry)
            }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .replaceError(with: [])
            .compactMap { $0.last }
            .receive(on: DispatchQueue.main)
            .assign(to: \.stats, on: self)
            .store(in: &subscriptions)
    }
}
