//
//  StatsGridCell.swift
//  covid-swiftui
//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI

struct StatsGridCell: View {
    let title: String
    let total: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(title.uppercased())
                        .bold()
                        .foregroundColor(.gray)
                    Text("\(total)")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .bold()
                        .scaledToFill()
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
        StatsGridCell(title: "Confirmed", total: 50)
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
