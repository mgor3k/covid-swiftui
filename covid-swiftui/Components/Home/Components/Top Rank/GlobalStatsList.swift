//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI
import Combine

struct GlobalStatsList: View {
    let countries: [SummaryCountry]
    let retryHandler: () -> Void
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            Text("Top 10 countries (by cases)")
                .font(.caption)
            
            if isLoading {
                ForEach(0...5, id: \.self) { _ in
                    ShimmerCell()
                }
                Spacer()
            } else {
                if countries.isEmpty {
                    Spacer()
                    VStack {
                        Text("No data to display")
                            .foregroundColor(.gray)
                        HStack(spacing: 0) {
                            Text("Try to ")
                                .foregroundColor(.gray)
                            Button("retry", action: retryHandler)
                        }
                    }
                    .font(.caption)
                    Spacer()
                } else {
                    ForEach(countries, id: \.self) { item in
                        GlobalStatsCell(item: item)
                    }
                }
            }
        }
    }
}

private struct ShimmerCell: View {
    var body: some View {
        HStack {
            ShimmerView()
                .frame(width: CGFloat.random(in: 80...100), height: 20)
            Spacer()
            ShimmerView()
                .frame(width: CGFloat.random(in: 40...60), height: 20)
        }
        .frame(height: 50)
        .padding(.horizontal, 32)
    }
}

struct GlobalStatsList_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsList(countries: [
//            .init(country: "Australia", totalConfirmed: 10, totalDeath: 5)
        ],
        retryHandler: {},
        isLoading: .constant(false)
        )
        .previewLayout(.fixed(width: 300, height: 600))
    }
}
