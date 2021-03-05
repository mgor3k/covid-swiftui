//
//  Created by Maciej Gorecki on 01/01/2021.
//

import Foundation
import SwiftUI

struct Resolver {
    let networking: Networking
    let storage: Storage
}

struct ResolverEnvironmentKey: EnvironmentKey {
    static let defaultValue: Resolver = Resolver(
        networking: NetworkManager(),
        storage: DefaultsStorage(defaults: .standard)
    )
}

extension EnvironmentValues {
    var resolver: Resolver {
        get { self[ResolverEnvironmentKey.self] }
        set { self[ResolverEnvironmentKey.self] = newValue }
    }
}
