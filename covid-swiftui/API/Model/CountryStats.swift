//
//  Created by Maciej Gorecki on 14/10/2020.
//

import Foundation

struct CountryStats: Decodable {
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
