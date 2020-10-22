//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let network: Networking
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var selectedCountry: String = "Poland"
    @Published var stats: CovidStats = .empty
    @Published var isLoading = false
    
    // TODO: Should be part of the model?
    var lastUpdated = Date()
    
    init(
        network: Networking) {
        self.network = network
        
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
                self.network.fetchLastStats(forCountry: $0)
            }
            .receive(on: DispatchQueue.main)
            .replaceError(with: .empty)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
                self?.lastUpdated = Date()
            })
            .assign(to: \.stats, on: self)
            .store(in: &subscriptions)
    }
}
