//
//  PopularBase.swift
//
//  Created by Stone on 20/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct PopularBase: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case nextOffset = "next_offset"
    case hasMore = "has_more"
    case estimatedTotal = "estimated_total"
    case results
  }

  var nextOffset: Int?
  var hasMore: Bool?
  var estimatedTotal: Int?
  var results: [DeviantDetailBase]?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.nextOffset <-- CodingKeys.nextOffset.rawValue
        mapper <<< self.hasMore <-- CodingKeys.hasMore.rawValue
        mapper <<< self.estimatedTotal <-- CodingKeys.estimatedTotal.rawValue
    }
}
