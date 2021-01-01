//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

class HomeStore: ObservableObject {
    private let provider: TotalCountryStatsProviding
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var selectedCountry = Country(country: "Poland", slug: "poland") // TODO: Temporary
    @Published var stats: TotalCountryStats = .empty
    @Published var isLoading = false
    
    init(
        provider: TotalCountryStatsProviding) {
        self.provider = provider
        
        $selectedCountry
            .dropFirst()
            .map { _ in true }
            .assign(to: \.isLoading, on: self)
            .store(in: &subscriptions)
    }
    
    func startFetching() {
        isLoading = true
        
        $selectedCountry
            .flatMap { [unowned self] in
                self.provider.totalStats(for: $0)
            }
            .receive(on: DispatchQueue.main)
            .replaceError(with: .empty)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .assign(to: \.stats, on: self)
            .store(in: &subscriptions)
    }
}
