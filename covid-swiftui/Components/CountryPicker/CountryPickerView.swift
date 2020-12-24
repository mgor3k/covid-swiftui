//
//  Created by Maciej Gorecki on 24/12/2020.
//

import SwiftUI

struct CountryPickerView: View {
    @ObservedObject var store: CountryPickerStore
    @Environment(\.presentationMode) var presentationMode
    
    init(store: CountryPickerStore = .default) {
        self.store = store
    }
    
    var body: some View {
        NavigationView {
            List(store.countries) { item in
                Button(item.country) {
                    print("Selected")
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.black)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Select country")
            .onAppear(perform: {
                store.fetchList()
            })
        }
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(store: .mock)
    }
}
