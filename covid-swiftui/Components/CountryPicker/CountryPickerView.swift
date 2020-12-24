//
//  Created by Maciej Gorecki on 24/12/2020.
//

import SwiftUI

struct CountryPickerView: View {
    @ObservedObject var store: CountryPickerStore
    
    init(store: CountryPickerStore = .default) {
        self.store = store
    }
    
    var body: some View {
        List(store.countries) { item in
            Text(item.country)
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear(perform: {
            store.fetchList()
        })
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(store: .mock)
    }
}
