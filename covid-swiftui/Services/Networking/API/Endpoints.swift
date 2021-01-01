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
        case summary
        case totalStats(country: String)
    }
    
    static func url(for endpoint: Endpoint) -> URL {
        switch endpoint {
        case .countries:
            return URL(string: baseURL + "/countries")!
        case .summary:
            return URL(string: baseURL + "/summary")!
        case .totalStats(let country):
            return URL(string: baseURL + "/total/country/" + country)!
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
