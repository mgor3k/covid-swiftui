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
            .flatMap { fetcher.loadStats(forCountry: $0) }
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.isLoading = true
            }, receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .compactMap { $0.last }
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .sink { [weak self] stats in
                self?.stats = stats
            }
            .store(in: &subscriptions)
    }
    
    func loadInitialStats() {
        let selectedCountry = self.selectedCountry
        let fetcher = self.fetcher
        
        cache
            .loadStats(forCountry: selectedCountry)
            .catch { _ in
                fetcher.loadStats(forCountry: selectedCountry)
            }
            .replaceError(with: [])
            .compactMap { $0.last }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stats in
                self?.stats = stats
            }
            .store(in: &subscriptions)
    }
}
