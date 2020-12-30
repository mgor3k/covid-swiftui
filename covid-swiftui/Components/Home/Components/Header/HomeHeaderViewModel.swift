//
//  Created by Maciej Gorecki on 22/10/2020.
//

import SwiftUI
import Combine

class HomeHeaderViewModel: ObservableObject {
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
    private let dateFormatter = LastUpdateDateFormatter()
    private var subscriptions: Set<AnyCancellable> = []
    
    let selectedCountry: Country
    let lastUpdated: Date
    @Published var dateString: String = ""
    
    @Published var canRefresh = false
    
    init(selectedCountry: Country, lastUpdated: Date) {
        self.selectedCountry = selectedCountry
        self.lastUpdated = lastUpdated
        
        updateDate()
        
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
        dateString = dateFormatter.localizedString(for: lastUpdated, relativeTo: Date())
        canRefresh = lastUpdated < Date().addingTimeInterval(-60)
    }
}
