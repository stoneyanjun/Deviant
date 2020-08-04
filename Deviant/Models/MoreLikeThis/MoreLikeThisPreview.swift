//
//  MoreLikeThisPreview.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisPreview: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case height
    case width
    case transparency
    case src
  }

  var height: Int?
  var width: Int?
  var transparency: Bool?
  var src: String?
}
