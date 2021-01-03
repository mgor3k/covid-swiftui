//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI
import Combine

struct HomeView: View {
    @Environment(\.resolver) var resolver
    @ObservedObject var viewModel: HomeViewModel
    @State var isPresentingCountries = false
    
    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 0) {
                ZStack {
                    Image("banner")
                        .resizable()
                        .overlay(Color.black.opacity(0.3))
                        .padding(.top, -metrics.safeAreaInsets.top)
                    
                    HomeHeaderView(viewModel: .init(
                        selectedCountry: viewModel.selectedCountry,
                        lastUpdated: viewModel.stats.updateDate
                    ),
                    onTapped: $isPresentingCountries,
                    onRefresh: viewModel.refreshCountry
                    )
                }
                .frame(height: metrics.size.height * 0.3)
                
                VStack {
                    // get rid of the metrics in the init
                    StatsGridView(viewModel: .init(stats: viewModel.stats), itemHeight: metrics.size.width * 0.3, isLoading: viewModel.isStatsLoading)
                        .frame(width: metrics.size.width * 0.8)
                        .offset(.init(width: 0, height: -36))
                    GlobalStatsList(countries: viewModel.topCountries, isLoading: $viewModel.isTopCountriesLoading)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $isPresentingCountries, content: {
            CountryPickerView(
                viewModel: .init(
                    provider: CountryPickerProvider(network: resolver.networking),
                    selectedCountry: $viewModel.selectedCountry
                )
            )
        })
        .onAppear(perform: {
            viewModel.startFetching()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(provider: MockProvider()))
    }
    
    struct MockProvider: TotalCountryStatsProviding, SummaryProviding {
        func totalStats(for country: Country) -> AnyPublisher<TotalCountryStats, Error> {
            Just(.init(confirmed: 1, deaths: 2, recovered: 3, active: 4))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        func summary() -> AnyPublisher<[SummaryCountry], Error> {
            Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
