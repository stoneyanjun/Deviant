//
//  DeviantDetailStats.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailStats: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case comments
    case favourites
  }

  var comments: Int?
  var favourites: Int?
}
