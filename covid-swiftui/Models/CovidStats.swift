//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation

struct CovidStats: Decodable {
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    
    enum CodingKeys: String, CodingKey {
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
    }
}

extension CovidStats: Equatable {}

extension CovidStats {
    static let empty: Self = .init(confirmed: 0, deaths: 0, recovered: 0, active: 0)
}
