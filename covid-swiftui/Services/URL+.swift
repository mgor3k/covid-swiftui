//
//  Created by Maciej Gorecki on 24/12/2020.
//

import Foundation

extension URL {
    static var baseURL: String {
        "https://api.covid19api.com"
    }
    
    enum Endpoint {
        case countries
    }
    
    static func url(for endpoint: Endpoint) -> URL {
        switch endpoint {
        case .countries:
            return URL(string: baseURL + "/countries")!
        }
    }
}

extension URLSession {
    func dataTaskPublisher(
        forEndpoint endpoint: URL.Endpoint
    ) -> DataTaskPublisher {
        dataTaskPublisher(for: .url(for: endpoint))
    }
}
