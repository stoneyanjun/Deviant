//
//  DeviantDetailContent.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailContent: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case height
    case src
    case filesize
    case transparency
    case width
  }

  var height: Int?
  var src: String?
  var filesize: Int?
  var transparency: Bool?
  var width: Int?
}
