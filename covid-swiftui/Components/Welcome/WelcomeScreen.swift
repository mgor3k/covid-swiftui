//
//  Created by Maciej Gorecki on 04/01/2021.
//

import SwiftUI

struct WelcomeScreen: View {
    @Environment(\.resolver) var resolver
    @Binding var selectedCountry: Country
    
    var body: some View {
        CountryPickerView(
            viewModel: .init(
                provider: CountryPickerProvider(network: resolver.networking),
                selectedCountry: $selectedCountry
            )
        )
        .onChange(of: selectedCountry, perform: { value in
            resolver.storage.setSelectedCountry(value)
        })
    }
}
