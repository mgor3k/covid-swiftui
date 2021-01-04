//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI
import Combine

struct HomeView: View {
    @Environment(\.resolver) var resolver
    @ObservedObject var viewModel: HomeViewModel
    @State var isPresentingCountries = false
    
    @State var rect = CGRect()
    
    var body: some View {
        ScrollView {
            GeometryReader { reader in
                ZStack {
                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(Color.black.opacity(0.3))
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height: reader.getParalaxHeight(from: 220))
                    
                    makeHeader()
                }
            }
            .frame(height: 220)
            
            VStack {
                makeStatsGrid()
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .offset(.init(width: 0, height: -36))
                makeTopRank()
                    .padding(.bottom, 16)
                    .background(Color.white.offset(x: 0, y: -18))
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $isPresentingCountries, content: {
            makeCountryPicker()
        })
        .onAppear(perform: viewModel.startFetching)
    }
}

private extension HomeView {
    func makeHeader() -> HomeHeaderView {
        HomeHeaderView(viewModel: .init(
            selectedCountry: viewModel.selectedCountry,
            lastUpdated: viewModel.stats.updateDate
        ),
        onTapped: $isPresentingCountries,
        onRefresh: viewModel.refreshCountry
        )
    }
    
    func makeStatsGrid() -> StatsGridView {
        StatsGridView(
            viewModel: .init(stats: viewModel.stats),
            itemHeight: UIScreen.main.bounds.width * 0.3,
            isLoading: viewModel.isStatsLoading
        )
    }
    
    func makeTopRank() -> GlobalStatsList {
        GlobalStatsList(
            countries: viewModel.topCountries,
            retryHandler: viewModel.fetchTopRank,
            isLoading: $viewModel.isTopCountriesLoading
        )
    }
    
    func makeCountryPicker() -> CountryPickerView {
        let viewModel = CountryPickerViewModel(
            provider: CountryPickerProvider(network: resolver.networking),
            selectedCountry: $viewModel.selectedCountry
        )
        return CountryPickerView(viewModel: viewModel)
    }
}

private extension GeometryProxy {
    func getParalaxHeight(from heigth: CGFloat) -> CGFloat {
        self.frame(in: .global).minY > -heigth ? self.frame(in: .global).minY + heigth : heigth
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init(provider: MockProvider(), selectedCountry: .init(country: "Poland", slug: "poland")))
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
