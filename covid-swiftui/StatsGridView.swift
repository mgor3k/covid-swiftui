//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct StatsModel {
    let title: String
    let value: Int
}

struct StatsGridView: View {
    private let layout = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    let itemHeight: CGFloat
    
    // Temporary
    let models: [StatsModel] = [
        .init(title: "Confirmed", value: 50),
        .init(title: "Active", value: 24),
        .init(title: "Recovered", value: 30),
        .init(title: "Deceased", value: 2)
    ]
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 24) {
            ForEach(models, id: \.title) { model in
                StatsGridCell(title: model.title, total: model.value)
                    .frame(height: itemHeight)
                    .background(Color.white.cornerRadius(10).shadow(color: Color.black.opacity(0.15), radius: 10))
            }
        }
    }
}

struct StatsGridView_Previews: PreviewProvider {
    static var previews: some View {
        StatsGridView(itemHeight: 100)
            .previewLayout(.sizeThatFits)
    }
}
