//
//  Created by Maciej Gorecki on 18/10/2020.
//

import SwiftUI

enum StatsGridElement {
    case confirmed(Int), active(Int), recovered(Int), deaths(Int)
}

extension StatsGridElement {
    var value: Int {
        switch self {
        case .confirmed(let value):
            return value
        case .active(let value):
            return value
        case .recovered(let value):
            return value
        case .deaths(let value):
            return value
        }
    }
    
    var title: String {
        switch self {
        case .confirmed:
            return "Confirmed"
        case .active:
            return "Active"
        case .recovered:
            return "Recovered"
        case .deaths:
            return "Deaths"
        }
    }
    
    var valueColor: Color {
        switch self {
        case .confirmed:
            return .red
        case .active:
            return .blue
        case .recovered:
            return .green
        case .deaths:
            return .gray
        }
    }
}
