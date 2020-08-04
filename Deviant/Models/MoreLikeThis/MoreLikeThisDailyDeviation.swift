//
//  MoreLikeThisDailyDeviation.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisDailyDeviation: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case time
    case body
    case suggester
    case giver
  }

  var time: String?
  var body: String?
  var suggester: MoreLikeThisSuggester?
  var giver: MoreLikeThisGiver?
}
