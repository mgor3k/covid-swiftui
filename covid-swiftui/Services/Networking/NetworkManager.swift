//
//  Created by Maciej Gorecki on 01/01/2021.
//

import Foundation
import Combine

class NetworkManager: Networking {
    func loadData(from endpoint: URL.Endpoint) -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(forEndpoint: endpoint)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
