//
//  UserStatusAuthor.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusAuthor: HandyJSON {

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
