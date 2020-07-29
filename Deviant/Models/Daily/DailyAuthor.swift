//
//  DailyAuthor.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailyAuthor: HandyJSON {
  enum CodingKeys: String, CodingKey {
    case username
    case type
    case usericon
    case userid
  }

  var username: String?
  var type: String?
  var usericon: String?
  var userid: String?
}
