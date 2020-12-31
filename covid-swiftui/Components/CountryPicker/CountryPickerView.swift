//
//  Created by Maciej Gorecki on 24/12/2020.
//

import SwiftUI

struct CountryPickerView: View {
    @ObservedObject var viewModel: CountryPickerViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List(viewModel.filteredCountries) { item in
                    Button(item.country) {
                        viewModel.selectedCountry = item
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(item == viewModel.selectedCountry ? .blue : .black)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Select country")
            }
            .onAppear(perform: {
                viewModel.fetchList()
            })
        }
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        let countries: [Country] = [
            .init(country: "Country 1", slug: "1"),
            .init(country: "Country 2", slug: "2")
        ]
        return CountryPickerView(
            viewModel: .mock(
                countries: countries,
                selectedCountry: countries.first!
            )
        )
    }
}
