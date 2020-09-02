//
//  TopicDetail.swift
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetail: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case results
        case hasMore = "has_more"
        case nextOffset = "next_offset"
    }

    var results: [DeviantDetailBase]?
    var hasMore: Bool?
    var nextOffset: Int?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
        mapper <<< self.nextOffset <-- CodingKeys.nextOffset.rawValue
    }
}
