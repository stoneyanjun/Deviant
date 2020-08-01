//
//  TopicDetailThumbs.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailThumbs: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case src
    case transparency
    case height
    case width
  }

  var src: String?
  var transparency: Bool?
  var height: Int?
  var width: Int?
}
