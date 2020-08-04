//
//  MoreLikeThisAuthor.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisAuthor: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case usericon
    case userid
    case type
    case username
  }

  var usericon: String?
  var userid: String?
  var type: String?
  var username: String?
}
