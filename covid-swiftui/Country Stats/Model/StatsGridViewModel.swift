//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Foundation

struct StatsGridViewModel {
    let items: [StatsGridElement]
    
    init(stats: CountryStats?) {
        self.items = [
            .confirmed(stats?.confirmed ?? 0),
            .active(stats?.active ?? 0),
            .recovered(stats?.recovered ?? 0),
            .deaths(stats?.deaths ?? 0)
        ]
    }
}
