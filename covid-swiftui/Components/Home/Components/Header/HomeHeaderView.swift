//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct HomeHeaderView: View {
    @ObservedObject var viewModel: HomeHeaderViewModel
    @Binding var onTapped: Bool
    
    var onRefresh: (() -> Void)
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Covid-19 Tracker")
                    .padding(.bottom, 48)
                
                Button(action: { onTapped = true }) {
                    Text(viewModel.selectedCountry.country)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.down")
                }
                
                Text(viewModel.dateString)
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .foregroundColor(.white)
            Spacer()
            
            VStack {
                Button(action: { onRefresh() }) {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .foregroundColor(.white)
                        .font(.title)
                        .opacity(viewModel.canRefresh ? 1 : 0.2)
                }
                .disabled(!viewModel.canRefresh)
                Spacer()
            }
        }
        .padding(24)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(
            viewModel: .init(
                selectedCountry: .init(country: "Poland", slug: "poland"),
                lastUpdated: Date().addingTimeInterval(-3)
            ),
            onTapped: .constant(false),
            onRefresh: {}
        )
        .background(Color.black)
        .previewLayout(.fixed(width: 400, height: 300))
    }
}
