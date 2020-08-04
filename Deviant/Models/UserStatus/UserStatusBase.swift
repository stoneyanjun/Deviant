//
//  UserStatusBase.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusBase: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case results
        case hasMore = "has_more"
    }

    var results: [UserStatusResults]?
    var hasMore: Bool?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
    }
}
