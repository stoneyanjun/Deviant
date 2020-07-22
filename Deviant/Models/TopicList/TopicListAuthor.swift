//
//  TopicListAuthor.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListAuthor: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case usericon
    case type
    case username
    case userid
  }

  var usericon: String?
  var type: String?
  var username: String?
  var userid: String?
}
