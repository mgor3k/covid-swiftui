//
//  Created by Maciej Gorecki on 04/01/2021.
//

import Foundation

protocol Storage {
    var lastSelectedCountry: Country? { get }
    func setSelectedCountry(_ country: Country)
}

class DefaultsStorage: Storage {
    private let lastCountryKey = "lastCountry"
    let defaults: UserDefaults
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    var lastSelectedCountry: Country? {
        guard let data = defaults.data(forKey: lastCountryKey) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(Country.self, from: data)
    }
    
    func setSelectedCountry(_ country: Country) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(country)
        defaults.set(data, forKey: lastCountryKey)
    }
}
