//
//  Created by Maciej Gorecki on 24/12/2020.
//

import SwiftUI

struct CountryPickerView: View {
    @ObservedObject var store: CountryPickerStore
    @Binding var selectedCountry: String
    
    @Environment(\.presentationMode) var presentationMode
    
    init(store: CountryPickerStore = .default,
         selectedCountry: Binding<String>) {
        self.store = store
        self._selectedCountry = selectedCountry
    }
    
    var body: some View {
        NavigationView {
            List(store.countries) { item in
                Button(item.country) {
                    selectedCountry = item.country
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
        CountryPickerView(store: .mock, selectedCountry: .constant(""))
    }
}
