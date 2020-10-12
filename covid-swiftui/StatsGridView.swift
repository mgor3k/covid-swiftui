//
//  StatsGridView.swift
//  covid-swiftui
//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct StatsGridView: View {
    private let layout = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    let itemHeight: CGFloat
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 24) {
            Color.blue
                .frame(height: itemHeight)
            Color.blue
                .frame(height: itemHeight)
            Color.blue
                .frame(height: itemHeight)
            Color.blue
                .frame(height: itemHeight)
        }
    }
}

struct StatsGridView_Previews: PreviewProvider {
    static var previews: some View {
        StatsGridView(itemHeight: 100)
            .previewLayout(.sizeThatFits)
    }
}
