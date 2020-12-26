//
//  Created by Maciej Gorecki on 26/12/2020.
//

import Foundation
import Combine

class GlobalStatsStore: ObservableObject {
    private let provider: SummaryProviding
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var countries: [SummaryCountry] = []
    
    init(provider: SummaryProviding) {
        self.provider = provider
    }
    
    func fetchCountries() {
        provider
            .summary()
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .assign(to: \.countries, on: self)
            .store(in: &subscriptions)
    }
}
