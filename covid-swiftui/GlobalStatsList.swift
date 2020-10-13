//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI

struct GlobalStatsList: View {
    let items: [Int] = (0...20).map { $0 }
    
    var body: some View {
        List(items, id: \.self) { item in
            GlobalStatsCell()
        }
    }
}

struct GlobalStatsList_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsList()
            .previewLayout(.fixed(width: 300, height: 600))
    }
}
