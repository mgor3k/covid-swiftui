//
//  Created by Maciej Gorecki on 26/12/2020.
//

import Foundation

struct SummaryResponse: Decodable {
    let countries: [SummaryCountry]
    
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
    }
}

struct SummaryCountry: Decodable {
    let country: String
    let totalConfirmed: Int
    let totalDeath: Int
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case totalConfirmed = "TotalConfirmed"
        case totalDeath = "TotalDeaths"
    }
}

extension SummaryCountry: Hashable {}
