//
//  String+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }

    static func getDateFormatString(timeStamp: String) -> String {
        guard let interval = TimeInterval(timeStamp) else {
            return ""
        }
        let date = Date(timeIntervalSince1970: interval)
        let dateformatter = DateFormatter()
        //自定义日期格式
        dateformatter.dateFormat = "yyyy-MM-dd"
        return dateformatter.string(from: date as Date)
    }

    static func decimalFormat(with number: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2

        return formatter.string(from: number) ?? ""
    }
}
