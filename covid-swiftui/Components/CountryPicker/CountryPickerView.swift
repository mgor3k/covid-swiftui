//
//  Created by Maciej Gorecki on 24/12/2020.
//

import SwiftUI

struct CountryPickerView: View {
    @ObservedObject var store: CountryPickerStore

    @Binding var selectedCountry: Country
    
    @Environment(\.presentationMode) var presentationMode
    
    init(store: CountryPickerStore = .default,
         selectedCountry: Binding<Country>) {
        self.store = store
        self._selectedCountry = selectedCountry
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $store.searchText)
                List(store.filteredCountries) { item in
                    Button(item.country) {
                        selectedCountry = item
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.black)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Select country")
            }
            .onAppear(perform: {
                store.fetchList()
            })
        }
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(store: .mock, selectedCountry: .constant(.init(country: "Poland", slug: "poland")))
    }
}
