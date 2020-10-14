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
                    StatsGridView(stats: viewModel.stats, itemHeight: metrics.size.width * 0.3)
                        .frame(width: metrics.size.width * 0.8)
                        .offset(.init(width: 0, height: -36))
                    GlobalStatsList()
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    struct MockStatsService: StatsFetching {
        func fetchStats(forCountry country: String) -> AnyPublisher<[CountryStats], Error> {
            Just([
                CountryStats(confirmed: 50, deaths: 100, recovered: 50, active: 10)
            ]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(service: MockStatsService(),
                                          startingStats: [
                                            .init(title: "Confirmed", value: 60),
                                            .init(title: "Active", value: 50),
                                            .init(title: "Recovered", value: 40),
                                            .init(title: "Deaths", value: 10)
                                          ]
        ))
    }
}

