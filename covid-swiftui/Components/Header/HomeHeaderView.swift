//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct HomeHeaderView: View {
    @ObservedObject var viewModel: HomeHeaderViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Covid-19 Tracker")
                    .padding(.bottom, 48)
                
                Button(action: {
                    print("Tapped")
                }, label: {
                    Text(viewModel.country)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.down")
                })
                
                Text(viewModel.dateString)
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .foregroundColor(.white)
            Spacer()
        }
        .padding(24)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(viewModel: .init(country: "Test", date: Date().addingTimeInterval(-3)))
            .background(Color.black)
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
