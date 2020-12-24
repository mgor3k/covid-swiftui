//
//  Created by Maciej Gorecki on 25/10/2020.
//

import Foundation

struct Country: Decodable {
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
