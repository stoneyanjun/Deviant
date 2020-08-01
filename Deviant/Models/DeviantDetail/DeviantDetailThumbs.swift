//
//  DeviantDetailThumbs.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailThumbs: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case transparency
    case width
    case src
    case height
  }

  var transparency: Bool?
  var width: Int?
  var src: String?
  var height: Int?
}
