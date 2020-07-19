//
//  ApiError.swift
//
//  Created by Stone on 19/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct ApiError {

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

