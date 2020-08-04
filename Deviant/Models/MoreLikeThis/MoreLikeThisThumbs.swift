//
//  MoreLikeThisThumbs.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisThumbs: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case src
    case height
    case width
    case transparency
  }

  var src: String?
  var height: Int?
  var width: Int?
  var transparency: Bool?
}
