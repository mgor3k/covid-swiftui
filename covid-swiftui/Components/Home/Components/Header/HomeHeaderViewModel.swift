//
//  Created by Maciej Gorecki on 22/10/2020.
//

import SwiftUI
import Combine

class HomeHeaderViewModel: ObservableObject {
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
    private let date: Date
    private let dateFormatter = LastUpdateDateFormatter()
    private var subscriptions: Set<AnyCancellable> = []
    
    let country: String
    @Published var dateString: String = ""
    
    init(country: String, date: Date) {
        self.country = country
        self.date = date
        updateDate()
        
        // TODO: Test this
        timer
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                self?.updateDate()
            })
            .store(in: &subscriptions)
    }
}

private extension HomeHeaderViewModel {
    func updateDate() {
        dateString = dateFormatter.localizedString(for: date, relativeTo: Date())
    }
}
