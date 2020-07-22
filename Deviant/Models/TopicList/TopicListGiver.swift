//
//  TopicListGiver.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListGiver: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case usericon
    case type
    case userid
    case username
  }

  var usericon: String?
  var type: String?
  var userid: String?
  var username: String?
}
