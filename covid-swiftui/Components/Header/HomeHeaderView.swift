//
//  Created by Maciej Gorecki on 12/10/2020.
//

import SwiftUI

struct HomeHeaderView: View {
    let country: String
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Covid-19 Tracker")
                    .padding(.bottom, 48)
                
                Button(action: {
                    print("Tapped")
                }, label: {
                    Text(country)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(systemName: "chevron.down")
                })
                
                Text(date.relativeDateString)
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

extension Date {
    var relativeDateString: String {
        let dateFormatter = RelativeDateTimeFormatter()
        var dateString = dateFormatter.string(for: self) ?? ""
        if timeIntervalSince(Date()) > -1 {
            dateString = "now"
        }
        return "Last updated: \(dateString)"
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(country: "Test", date: Date().addingTimeInterval(-3))
            .background(Color.black)
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
