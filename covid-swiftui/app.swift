//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI

@main
struct app: App {
    let resolver = Resolver(
        networking: LocalNetworkManager()
    )
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                store: .init(provider: TotalCountryStatsProvider(network: resolver.networking))
            )
            .environment(\.resolver, resolver)
        }
    }
}
