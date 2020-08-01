//
//  String+Extension.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
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
}
