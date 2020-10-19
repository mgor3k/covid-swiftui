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
    var network: Networking { get }
}

struct ServiceFactory: ServiceFactoring {
    let network: Networking = NetworkService(session: URLSession.shared)
}

struct ViewModelFactory {
    let home: HomeViewModel
    
    init(services: ServiceFactoring) {
        self.home = HomeViewModel(network: services.network)
    }
}
