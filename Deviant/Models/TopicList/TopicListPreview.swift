//
//  TopicListPreview.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListPreview: HandyJSON {

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
