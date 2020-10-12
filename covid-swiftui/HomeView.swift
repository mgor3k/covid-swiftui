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
                
                Color.purple
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
