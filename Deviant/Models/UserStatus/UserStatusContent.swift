//
//  UserStatusContent.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusContent: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case filesize
    case height
    case transparency
    case width
    case src
  }

  var filesize: Int?
  var height: Int?
  var transparency: Bool?
  var width: Int?
  var src: String?
}
