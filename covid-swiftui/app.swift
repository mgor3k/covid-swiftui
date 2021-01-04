//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI

@main
struct app: App {
    let resolver = Resolver(
        // LocalNetworkManager() or NetworkManager() for real requests
        networking: NetworkManager(),
        storage: DefaultsStorage(defaults: .standard)
    )
    
    @State var selectedCountry: Country
    
    init() {
        _selectedCountry = State(initialValue: resolver.storage.lastSelectedCountry ?? .empty)
    }
    
    var body: some Scene {
        WindowGroup {
            if selectedCountry == .empty {
                makeWelcome()
                    .environment(\.resolver, resolver)
            } else {
                makeHome()
                    .environment(\.resolver, resolver)
            }
        }
    }
}

extension app {
    func makeWelcome() -> WelcomeScreen {
        WelcomeScreen(selectedCountry: $selectedCountry)
    }
    
    func makeHome() -> HomeView {
        let viewModel = HomeViewModel(
            provider: HomeProvider(network: resolver.networking),
            selectedCountry: selectedCountry
        )
        return HomeView(viewModel: viewModel)
    }
}
