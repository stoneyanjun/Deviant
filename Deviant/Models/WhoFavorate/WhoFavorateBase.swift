//
//  WhoFavorateBase.swift
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct WhoFavorateBase: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case results
        case nextOffset = "next_offset"
    }

    var hasMore: Bool?
    var results: [WhoFavorateModel]?
    var nextOffset: Int?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
        mapper <<< self.nextOffset <-- CodingKeys.nextOffset.rawValue
    }
}
