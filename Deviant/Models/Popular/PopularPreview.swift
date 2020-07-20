//
//  PopularPreview.swift
//
//  Created by Stone on 20/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct PopularPreview: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case height
    case transparency
    case src
    case width
  }

  var height: Int?
  var transparency: Bool?
  var src: String?
  var width: Int?
}
