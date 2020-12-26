//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI

struct GlobalStatsCell: View {
    let item: SummaryCountry
    
    var body: some View {
        HStack {
            Text(item.country)
            Spacer()
            Text("\(item.totalConfirmed)")
            Text("☠️ \(item.totalDeath)")
                .font(.caption2)
                .bold()
        }
        .padding()
    }
}

struct GlobalStatsCell_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsCell(item: .init(country: "Poland", totalConfirmed: 50, totalDeath: 100))
            .previewLayout(.fixed(width: 500, height: 100))
    }
}
