//
//  Created by Maciej Gorecki on 22/10/2020.
//

import XCTest
@testable import covid_swiftui

class LastUpdateDateFormatterTests: XCTestCase {
    private let formatter = LastUpdateDateFormatter()
    
    func test_relativeTime_yesterday() {
        // 21/10/2020
        let yesterday = Date(timeIntervalSince1970: 1603300281)
        
        // 22/10/2020
        let today = Date(timeIntervalSince1970: 1603386681)
        
        XCTAssertEqual(formatter.localizedString(for: yesterday, relativeTo: today), "Last updated: 1 day ago")
    }
    
    func test_relativeTime_now() {
        // 22/10/2020
        let date = Date(timeIntervalSince1970: 1603386681)
        
        XCTAssertEqual(formatter.localizedString(for: date, relativeTo: date), "Last updated: now")
    }

    func test_relativeTime_hourAgo() {
        // 22/10/2020 18:11:21
        let oneHourAgo = Date(timeIntervalSince1970: 1603383081)

        // 22/10/2020 19:11:21
        let now = Date(timeIntervalSince1970: 1603386681)

        XCTAssertEqual(formatter.localizedString(for: oneHourAgo, relativeTo: now), "Last updated: 1 hour ago")
    }

}
