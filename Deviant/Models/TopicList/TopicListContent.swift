//
//  TopicListContent.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListContent: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case transparency
    case width
    case src
    case height
    case filesize
  }

  var transparency: Bool?
  var width: Int?
  var src: String?
  var height: Int?
  var filesize: Int?
}
