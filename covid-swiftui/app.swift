//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI

@main
struct app: App {
    let resolver = Resolver(
        // switch to NetworkManager() for real requests
        networking: LocalNetworkManager()
    )
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: .init(provider: TotalCountryStatsProvider(network: resolver.networking))
            )
            .environment(\.resolver, resolver)
        }
    }
}
