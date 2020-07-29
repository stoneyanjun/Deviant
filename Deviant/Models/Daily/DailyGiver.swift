//
//  DailyGiver.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailyGiver: HandyJSON {
  enum CodingKeys: String, CodingKey {
    case userid
    case type
    case username
    case usericon
  }

  var userid: String?
  var type: String?
  var username: String?
  var usericon: String?
}
