//
//  TopicDetailDailyDeviation.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailDailyDeviation: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case body
    case giver
    case time
  }

  var body: String?
  var giver: TopicDetailGiver?
  var time: String?
}
