//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI

@main
struct app: App {
    let resolver = Resolver(
        // LocalNetworkManager() or NetworkManager() for real requests
        networking: NetworkManager()
    )
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: .init(provider: HomeProvider(network: resolver.networking))
            )
            .environment(\.resolver, resolver)
        }
    }
}
