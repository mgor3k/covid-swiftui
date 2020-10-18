//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct StatsGridView: View {
    private let layout = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    let stats: CountryStats?
    let itemHeight: CGFloat
    
    // TODO: Looks like shit
    private var models: [StatsModel] {
        return [StatsModel.init(title: "Confirmed", value: stats?.confirmed ?? 0),
         StatsModel.init(title: "Active", value: stats?.active ?? 0),
         StatsModel.init(title: "Recovered", value: stats?.recovered ?? 0),
         StatsModel.init(title: "Deaths", value: stats?.deaths ?? 0)]
    }
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 24) {
            ForEach(models, id: \.title) { model in
                StatsGridCell(title: model.title, value: model.value)
                    .frame(height: itemHeight)
                    .background(Color.white.shadow(color: Color.black.opacity(0.15), radius: 10))
            }
        }
    }
}

struct StatsGridView_Previews: PreviewProvider {
    static var previews: some View {
        StatsGridView(stats: .empty, itemHeight: 100)
            .previewLayout(.sizeThatFits)
    }
}
