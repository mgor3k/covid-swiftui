//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI

struct GlobalStatsList: View {
    @ObservedObject var store: GlobalStatsStore
    
    init(store: GlobalStatsStore = .default) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            Text("Top 10 countries (by cases)")
                .font(.caption)
            List(store.countries, id: \.self) { item in
                GlobalStatsCell(item: item)
            }
        }
        .onAppear(perform: {
            store.fetchCountries()
        })
    }
}

struct GlobalStatsList_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsList(store: .mock)
            .previewLayout(.fixed(width: 300, height: 600))
    }
}
