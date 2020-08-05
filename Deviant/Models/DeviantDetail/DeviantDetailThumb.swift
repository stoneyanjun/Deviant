//
//  DeviantDetailThumb.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailThumb: HandyJSON {

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
