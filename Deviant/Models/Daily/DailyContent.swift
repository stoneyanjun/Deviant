//
//  DailyContent.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailyContent: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case height
    case width
    case src
    case filesize
    case transparency
  }

  var height: Int?
  var width: Int?
  var src: String?
  var filesize: Int?
  var transparency: Bool?
}
