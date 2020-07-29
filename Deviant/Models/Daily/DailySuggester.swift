//
//  DailySuggester.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailySuggester: HandyJSON {
  enum CodingKeys: String, CodingKey {
    case type
    case usericon
    case username
    case userid
  }

  var type: String?
  var usericon: String?
  var username: String?
  var userid: String?
}
