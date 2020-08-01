//
//  TopicDetailAuthor.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailAuthor: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case usericon
    case userid
    case username
    case type
  }

  var usericon: String?
  var userid: String?
  var username: String?
  var type: String?
}
