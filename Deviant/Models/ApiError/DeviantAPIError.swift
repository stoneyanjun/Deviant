//
//  DeviantAPIError.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantAPIError: HandyJSON {
    enum CodingKeys: String {
        case status
        case errorDescription = "error_description"
        case error
    }

    var status: String?
    var errorDescription: String?
    var error: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.errorDescription <-- CodingKeys.errorDescription.rawValue
    }
}
