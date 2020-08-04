//
//  CommentUser.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct CommentUser: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case username
    case usericon
    case type
    case userid
  }

  var username: String?
  var usericon: String?
  var type: String?
  var userid: String?
}
