//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Foundation
import Combine

struct Factory {
    let viewModels: ViewModelFactory
    
    init(services: ServiceFactoring) {
        viewModels = ViewModelFactory(services: services)
    }
    
    static let prod: Factory = .init(services: ServiceFactory())
    static let preview: Factory = .init(services: PreviewServiceFactory())
}

protocol ServiceFactoring {
    var network: Networking { get }
}

struct ServiceFactory: ServiceFactoring {
    let network: Networking = NetworkService(session: URLSession.shared)
}

struct PreviewServiceFactory: ServiceFactoring {
    struct PreviewNetworking: Networking {
        func fetchLastStats(forCountry country: String) -> AnyPublisher<CovidStats, Error> {
            Just(CovidStats.empty).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    let network: Networking = PreviewNetworking()
}

struct ViewModelFactory {
    let home: HomeViewModel
    
    init(services: ServiceFactoring) {
        self.home = HomeViewModel(network: services.network)
    }
}
