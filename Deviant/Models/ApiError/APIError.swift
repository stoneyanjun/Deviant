//
//  DeviantFailure.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.

import Foundation
import HandyJSON

struct APIError: HandyJSON {
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
