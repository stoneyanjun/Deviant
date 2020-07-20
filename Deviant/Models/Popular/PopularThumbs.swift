//
//  PopularThumbs.swift
//
//  Created by Stone on 20/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct PopularThumbs: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case transparency
    case width
    case height
    case src
  }

  var transparency: Bool?
  var width: Int?
  var height: Int?
  var src: String?
}
