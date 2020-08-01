//
//  TopicListDailyDeviation.swift
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListDailyDeviation: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case giver
    case body
    case time
    case suggester
  }

  var giver: TopicListGiver?
  var body: String?
  var time: String?
  var suggester: TopicListSuggester?
}
