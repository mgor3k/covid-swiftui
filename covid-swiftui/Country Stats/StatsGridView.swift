//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct StatsGridView: View {
    private let layout = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    let viewModel: StatsGridViewModel
    let itemHeight: CGFloat
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 24) {
            ForEach(viewModel.items, id: \.title) {
                StatsGridCell(title: $0.title, value: $0.value)
                    .frame(height: itemHeight)
                    .background(Color.white.shadow(color: Color.black.opacity(0.15), radius: 10))
            }
        }
    }
}

struct StatsGridView_Previews: PreviewProvider {
    static var previews: some View {
        StatsGridView(viewModel: .init(stats: .empty), itemHeight: 100)
            .previewLayout(.sizeThatFits)
    }
}
