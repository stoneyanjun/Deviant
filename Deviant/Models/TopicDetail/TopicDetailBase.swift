//
//  TopicDetailBase.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailBase: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case results
        case hasMore = "has_more"
        case nextOffset = "next_offset"
    }

    var results: [TopicDetailResult]?
    var hasMore: Bool?
    var nextOffset: Int?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
        mapper <<< self.nextOffset <-- CodingKeys.nextOffset.rawValue
    }
}
