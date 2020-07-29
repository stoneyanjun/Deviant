//
//  DailyBase.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailyBase: HandyJSON {
  enum CodingKeys: String, CodingKey {
    case results
  }

  var results: [DailyResult]?
}
