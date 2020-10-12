//
//  HomeHeaderView.swift
//  covid-swiftui
//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Covid-19 Tracker")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 48, trailing: 0))
                
                Button(action: {
                    print("Tapped")
                }, label: {
                    Text("India")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.down")
                })
                
                Text("Last updated 1 hour ago")
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .foregroundColor(.white)
            Spacer()
        }
        .padding(24)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
            .background(Color.black)
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
