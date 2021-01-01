//
//  Created by Maciej Gorecki on 01/01/2021.
//

import Foundation
import Combine

protocol Networking {
    func loadData(from endpoint: URL.Endpoint) -> AnyPublisher<Data, URLError>
}
