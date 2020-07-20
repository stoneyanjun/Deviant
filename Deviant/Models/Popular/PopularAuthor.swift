//
//  PopularAuthor.swift
//
//  Created by Stone on 20/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct PopularAuthor: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case userid
    case type
    case usericon
    case username
  }

  var userid: String?
  var type: String?
  var usericon: String?
  var username: String?
}
