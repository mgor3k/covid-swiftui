//
//  Created by Maciej Gorecki on 01/01/2021.
//

import Foundation
import Combine

class LocalNetworkManager: Networking {
    func loadData(from endpoint: URL.Endpoint) -> AnyPublisher<Data, URLError> {
        let jsonFile = Bundle.main.url(forResource: endpoint.fileName, withExtension: "json")!
        let data = try! Data(contentsOf: jsonFile)
        return Just(data)
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}

private extension URL.Endpoint {
    var fileName: String {
        switch self {
        case .countries:
            return "countries"
        default:
            return ""
        }
    }
}
