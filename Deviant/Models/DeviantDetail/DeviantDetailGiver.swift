//
//  DeviantDetailGiver.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailGiver: HandyJSON {

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
