//
//  Created by Maciej Gorecki on 25/10/2020.
//

import Foundation

struct Country: Codable {
    let country: String
    let slug: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
    }
}

extension Country: Identifiable {
    var id: String { slug }
}

extension Country: Equatable { }

extension Country {
    static let empty = Country(country: "", slug: "")
}
