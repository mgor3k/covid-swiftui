//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    private let service: StatsFetching
    private var subscriptions: [AnyCancellable] = []
    
    @Published var selectedCountry: String = "Poland"
    @Published var stats: [StatsModel]
    
    init(service: StatsFetching = StatsService(), startingStats: [StatsModel] = []) {
        self.service = service
        
        // fetch from some cache
        self.stats = startingStats
        
        service
            .fetchStats(forCountry: selectedCountry)
            .compactMap { $0.last }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                print(status)
            }, receiveValue: { [weak self] stats in
                var models: [StatsModel] = []
                // make this a viewModel?
                models.append(.init(title: "Confirmed", value: stats.confirmed))
                models.append(.init(title: "Active", value: stats.active))
                models.append(.init(title: "Recovered", value: stats.recovered))
                models.append(.init(title: "Deaths", value: stats.deaths))
                self?.stats = models
            })
            .store(in: &subscriptions)
    }
}
