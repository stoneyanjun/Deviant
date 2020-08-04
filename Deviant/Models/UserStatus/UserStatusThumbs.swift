//
//  UserStatusThumbs.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusThumbs: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case width
    case transparency
    case src
    case height
  }

  var width: Int?
  var transparency: Bool?
  var src: String?
  var height: Int?
}
