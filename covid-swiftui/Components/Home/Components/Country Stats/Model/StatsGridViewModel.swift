//
//  Created by Maciej Gorecki on 18/10/2020.
//

import Foundation

struct StatsGridViewModel {
    let items: [StatsGridElement]
    
    init(stats: TotalCountryStats) {
        self.items = [
            .confirmed(stats.confirmed),
            .active(stats.active),
            .recovered(stats.recovered),
            .deaths(stats.deaths)
        ]
    }
}
