//
//  Date+Extension.swift
//  Deviant
//
//  Created by Stone on 4/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import SwifterSwift

extension Date {
    static func fromatPostedDate(postedDateStr: String) -> String {
        //yyyy-MM-dd'T'HH:mm:ss-SSSZ
        guard let date = Date(deviantDateString: postedDateStr) else {
            return postedDateStr
        }

        let minutes = -date.timeIntervalSinceNow / 60

        if minutes < 5 {
            return "Just now"
        } else if minutes < 60 {
            return "\(Int(minutes)) minutes ago"
        } else if minutes < (60 * 12) {
            return "\(Int(minutes / 60)) hours ago"
        } else if date.isInToday {
            return "Today"
        } else if date.isInYesterday {
            return "Yesterday"
        } else {
            let days = minutes / (60 * 24)
            if days < 5 {
                return "\(Int(days)) days ago"
            } else {
                return date.formatString(dateFormat: "MMMM dd, yyyy")
            }
        }
    }

    init?(deviantDateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-SSSS"
        guard let date = dateFormatter.date(from: deviantDateString) else { return nil }
        self = date
    }

    func formatString(dateFormat: String = "yyyy-MM-dd") -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        return dateformatter.string(from: self)
    }
}
