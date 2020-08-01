//
//  TopicDetailContent.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailContent: HandyJSON {
    enum CodingKeys: String, CodingKey {
    case height
    case filesize
    case src
    case transparency
    case width
  }

  var height: Int?
  var filesize: Int?
  var src: String?
  var transparency: Bool?
  var width: Int?
}
