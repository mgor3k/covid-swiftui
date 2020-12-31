//
//  Created by Maciej Gorecki on 31/12/2020.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "exclamationmark.square")
                .font(.system(size: 60))
                .foregroundColor(Color.red)
            
            Text("\(error.localizedDescription)")
            Button("Retry", action: retry)
                .font(.title)
                .padding()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            error: URLError(URLError.Code(rawValue: 123)),
            retry: {}
        )
    }
}
