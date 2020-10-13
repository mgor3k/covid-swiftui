//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI

struct GlobalStatsCell: View {
    var body: some View {
        HStack {
            HStack {
                Text("Poland")
                Spacer()
            }
            Text("175")
            Text("165")
            Text("100")
            Text("30")
        }
        .padding()
    }
}

struct GlobalStatsCell_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsCell()
            .previewLayout(.fixed(width: 500, height: 100))
    }
}
