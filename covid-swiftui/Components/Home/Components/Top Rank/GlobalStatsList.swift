//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI
import Combine

struct GlobalStatsList: View {
    @ObservedObject var viewModel: GlobalStatsViewModel
    
    var body: some View {
        VStack {
            Text("Top 10 countries (by cases)")
                .font(.caption)
            List(viewModel.countries, id: \.self) { item in
                GlobalStatsCell(item: item)
            }
        }
        .onAppear(perform: viewModel.fetchCountries)
    }
}

struct GlobalStatsList_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsList(viewModel: .init(provider: MockProvider()))
            .previewLayout(.fixed(width: 300, height: 600))
    }
    
    struct MockProvider: SummaryProviding {
        func summary() -> AnyPublisher<[SummaryCountry], Error> {
            Just([
                .init(country: "Australia", totalConfirmed: 10, totalDeath: 5)
            ])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
    }
}
