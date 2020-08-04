//
//  MoreLikeThisBase.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisBase: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case results
        case nextOffset = "next_offset"
        case hasMore = "has_more"
    }

    var results: [DeviantDetailBase]?
    var nextOffset: Int?
    var hasMore: Bool?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.nextOffset <-- CodingKeys.nextOffset.rawValue
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
    }
}

