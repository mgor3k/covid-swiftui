//
//  Created by Maciej Gorecki on 24/12/2020.
//

import SwiftUI
import Combine

struct CountryPickerView: View {
    @ObservedObject var viewModel: CountryPickerViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        AsyncContentView(source: viewModel) { countries in
            NavigationView {
                VStack {
                    SearchBar(text: $viewModel.searchText)
                    List(countries) { item in
                        Button(item.country) {
                            viewModel.selectedCountry = item
                            presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(item == viewModel.selectedCountry ? .blue : .black)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarTitle("Select a country")
                }
            }
        }
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(
            viewModel: .init(
                provider: MockProvider(),
                selectedCountry: .constant(.init(country: "Poland", slug: "poland"))
            )
        )
    }
    
    struct MockProvider: CountryListProviding {
        func getCountryList() -> AnyPublisher<[Country], Error> {
            Just([
                Country(country: "Poland", slug: "poland"),
                Country(country: "UK", slug: "uk")
            ])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }
}
