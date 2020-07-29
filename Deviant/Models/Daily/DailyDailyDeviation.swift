//
//  DailyDailyDeviation.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailyDailyDeviation: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case body
    case giver
    case suggester
    case time
  }

  var body: String?
  var giver: DailyGiver?
  var suggester: DailySuggester?
  var time: String?
}
