//
//  DeviantDetailDailyDeviation.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailDailyDeviation: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case time
    case giver
    case body
  }

  var time: String?
  var giver: DeviantDetailGiver?
  var body: String?
}
