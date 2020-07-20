//
//  PopularContent.swift
//
//  Created by Stone on 20/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct PopularContent: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case height
    case filesize
    case transparency
    case width
    case src
  }

  var height: Int?
  var filesize: Int?
  var transparency: Bool?
  var width: Int?
  var src: String?
}
