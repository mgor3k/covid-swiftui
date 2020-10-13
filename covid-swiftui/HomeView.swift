//
//  HomeView.swift
//  covid-swiftui
//
//  Created by Maciej Gorecki on 06/10/2020.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 0) {
                ZStack {
                    // going to be a imageview
                    Color.black
                        .padding(.top, -metrics.safeAreaInsets.top)
                    
                    HomeHeaderView()
                }
                .frame(height: metrics.size.height * 0.3)
                
                ZStack {
                    Color.purple
                    VStack {
                        StatsGridView(itemHeight: metrics.size.width * 0.3)
                            .frame(width: metrics.size.width * 0.8)
                            .offset(.init(width: 0, height: -36))
                        GlobalStatsList()
                        Spacer()
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
