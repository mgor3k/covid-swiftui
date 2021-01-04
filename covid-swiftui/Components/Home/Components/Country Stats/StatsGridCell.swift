//
//  StatsGridCell.swift
//  covid-swiftui
//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI

struct StatsGridCell: View {
    let item: StatsGridElement
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(item.title.uppercased())
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(item.value)")
                        .foregroundColor(item.valueColor)
                        .font(.system(size: 50))
                        .bold()
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct StatsGridCell_Previews: PreviewProvider {
    static var previews: some View {
        StatsGridCell(item: .confirmed(52))
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
