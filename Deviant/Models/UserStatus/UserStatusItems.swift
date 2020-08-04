//
//  UserStatusItems.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusItems: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case deviation
    case type
  }

  var deviation: UserStatusDeviation?
  var type: String?
}
