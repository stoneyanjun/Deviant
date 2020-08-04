//
//  MoreLikeThisContent.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisContent: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case src
    case height
    case filesize
    case width
    case transparency
  }

  var src: String?
  var height: Int?
  var filesize: Int?
  var width: Int?
  var transparency: Bool?
}
