//
//  Created by Maciej Gorecki on 01/01/2021.
//

import Foundation
import Combine

class LocalNetworkManager: Networking {
    func loadData(from endpoint: URL.Endpoint) -> AnyPublisher<Data, URLError> {
        Just(endpoint.data)
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}

private extension URL.Endpoint {
    var fileName: String? {
        switch self {
        case .countries:
            return "countries"
        default:
            return nil
        }
    }
    
    var data: Data {
        switch self {
        case .countries, .summary:
            let jsonFile = Bundle.main.url(forResource: fileName!, withExtension: "json")!
            let data = try! Data(contentsOf: jsonFile)
            return data
        case .totalStats:
            let data = """
            [
              {
                "Confirmed": \(Int.random(in: 0...20_000)),
                "Deaths": \(Int.random(in: 0...5_000)),
                "Recovered": \(Int.random(in: 0...20_000)),
                "Active": \(Int.random(in: 0...10_000))
              }
            ]
            """.data(using: .utf16)
            return data!
        }
    }
}
