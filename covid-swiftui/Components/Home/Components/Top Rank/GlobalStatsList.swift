//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI
import Combine

struct GlobalStatsList: View {
    let countries: [SummaryCountry]
    
    var body: some View {
        VStack {
            Text("Top 10 countries (by cases)")
                .font(.caption)
            List(countries, id: \.self) { item in
                GlobalStatsCell(item: item)
            }
        }
    }
}

struct GlobalStatsList_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsList(countries: [
            .init(country: "Australia", totalConfirmed: 10, totalDeath: 5)
        ])
        .previewLayout(.fixed(width: 300, height: 600))
    }
}
