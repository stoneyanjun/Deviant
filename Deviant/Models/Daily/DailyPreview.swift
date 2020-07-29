//
//  DailyPreview.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailyPreview: HandyJSON {
  enum CodingKeys: String, CodingKey {
    case height
    case src
    case width
    case transparency
  }

  var height: Int?
  var src: String?
  var width: Int?
  var transparency: Bool?
}
