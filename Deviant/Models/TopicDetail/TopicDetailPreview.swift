//
//  TopicDetailPreview.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailPreview: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case transparency
    case height
    case width
    case src
  }

  var transparency: Bool?
  var height: Int?
  var width: Int?
  var src: String?
}
