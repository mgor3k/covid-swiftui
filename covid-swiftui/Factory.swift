//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Foundation

struct Factory {
    let viewModels: ViewModelFactory
    
    init(services: ServiceFactoring = ServiceFactory()) {
        viewModels = ViewModelFactory(services: services)
    }
}

protocol ServiceFactoring {
    var fetcher: StatsLoading { get }
    var cache: StatsCache { get }
}

struct ServiceFactory: ServiceFactoring {
    let fetcher: StatsLoading = StatsService()
    let cache: StatsCache = CoreDataCache()
}

struct ViewModelFactory {
    let home: HomeViewModel
    
    init(services: ServiceFactoring) {
        self.home = HomeViewModel(fetcher: services.fetcher, cache: services.cache)
    }
}
