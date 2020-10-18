//
//  StatsGridCell.swift
//  covid-swiftui
//
//  Created by Maciej Gorecki on 13/10/2020.
//

import SwiftUI

struct StatsGridCell: View {
    let title: String
    let value: Int?
    
    private var valueString: String {
        if let value = value {
            return "\(value)"
        }
        return "-"
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text(title.uppercased())
                        .bold()
                        .foregroundColor(.gray)
                    Text(valueString)
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
        StatsGridCell(title: "Confirmed", value: 50)
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
