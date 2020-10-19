//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Foundation
import Combine

protocol Networking {
    func fetchLastStats(forCountry country: String) -> AnyPublisher<CovidStats, Error>
}
