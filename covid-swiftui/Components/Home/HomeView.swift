//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject
    var viewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 0) {
                ZStack {
                    Image("banner")
                        .resizable()
                        .overlay(Color.black.opacity(0.3))
                        .padding(.top, -metrics.safeAreaInsets.top)
                    
                    HomeHeaderView(country: viewModel.selectedCountry)
                }
                .frame(height: metrics.size.height * 0.3)
                
                VStack {
                    // get rid of the metrics in the init
                    StatsGridView(viewModel: .init(stats: viewModel.stats), itemHeight: metrics.size.width * 0.3)
                        .frame(width: metrics.size.width * 0.8)
                        .offset(.init(width: 0, height: -36))
                    GlobalStatsList()
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear(perform: {
            viewModel.startFetching()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: Factory.preview.viewModels.home)
    }
}
