//
//  UserStatusPreview.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusPreview: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case height
    case transparency
    case width
    case src
  }

  var height: Int?
  var transparency: Bool?
  var width: Int?
  var src: String?
}
