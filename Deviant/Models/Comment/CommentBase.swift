//
//  CommentBase.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct CommentBase: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case total
        case hasLess = "has_less"
        case thread
        case hasMore = "has_more"
        case nextOffset = "next_offset"
    }

    var total: Int?
    var hasLess: Bool?
    var thread: [CommentThread]?
    var hasMore: Bool?
    var nextOffset: Int?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.hasLess <-- CodingKeys.hasLess.rawValue
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
        mapper <<< self.nextOffset <-- CodingKeys.nextOffset.rawValue
    }
}
