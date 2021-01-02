//
//  Created by Maciej Gorecki on 26/12/2020.
//

import Foundation
import Combine

protocol SummaryProviding {
    func summary() -> AnyPublisher<[SummaryCountry], Error>
}
