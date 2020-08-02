//
//  TopicListBase.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListBase: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case nextOffset = "next_offset"
    case results
    case hasMore = "has_more"
  }

  var nextOffset: Int?
  var results: [TopicListResult]?
  var hasMore: Bool?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.nextOffset <-- CodingKeys.nextOffset.rawValue
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
    }
}
