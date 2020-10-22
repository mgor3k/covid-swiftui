//
//  Created by Maciej Gorecki on 22/10/2020.
//

import Foundation

class LastUpdateDateFormatter: RelativeDateTimeFormatter {
    override func localizedString(for date: Date, relativeTo referenceDate: Date) -> String {
        let dateString: String = {
            if date.timeIntervalSince(referenceDate) > -1 {
                return "now"
            }
            return super.localizedString(for: date, relativeTo: referenceDate)
        }()
        return "Last updated: \(dateString)"
    }
}
