//
//  Date+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import SwifterSwift

extension Date {
    static func fromatFavorateDate(with timeStamp: String) -> String {
        guard let interval = TimeInterval(timeStamp) else {
            return ""
            }
        let date = Date(timeIntervalSince1970: interval)
        return date.getFormatDateString()
    }

    static func fromatPostedDate(postedDateStr: String) -> String {
        //yyyy-MM-dd'T'HH:mm:ss-SSSZ
        guard let date = Date(deviantDateString: postedDateStr) else {
            return postedDateStr
        }
        return date.getFormatDateString()
    }

    func getFormatDateString() -> String {
        let minutes = -(self.timeIntervalSinceNow / 60)

        if minutes < 5 {
            return "Just now"
        } else if minutes < 60 {
            return "\(Int(minutes)) minutes ago"
        } else if minutes < (60 * 12) {
            return "\(Int(minutes / 60)) hours ago"
        } else if self.isInToday {
            return "Today"
        } else if self.isInYesterday {
            return "Yesterday"
        } else {
            let days = minutes / (60 * 24)
            if days < 5 {
                return "\(Int(days)) days ago"
            } else {
                return self.formatString(dateFormat: "MMMM dd, yyyy")
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
