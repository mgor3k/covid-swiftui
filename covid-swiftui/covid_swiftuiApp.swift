//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI

@main
struct covid_swiftuiApp: App {
    let factory = Factory.prod
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: factory.viewModels.home)
        }
    }
}
