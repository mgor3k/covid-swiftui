//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation

struct TotalCountryStats: Decodable {
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    
    let updateDate = Date()
    
    enum CodingKeys: String, CodingKey {
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
    }
}

extension TotalCountryStats: Equatable {}

extension TotalCountryStats {
    static let empty: Self = .init(confirmed: 0, deaths: 0, recovered: 0, active: 0)
}
