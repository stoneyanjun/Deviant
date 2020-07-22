//
//  TopicListSuggester.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListSuggester: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case username
    case type
    case userid
    case usericon
  }

  var username: String?
  var type: String?
  var userid: String?
  var usericon: String?
}
