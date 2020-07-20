//
//  PopularStats.swift
//
//  Created by Stone on 20/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct PopularStats: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case comments
    case favourites
  }

  var comments: Int?
  var favourites: Int?
}
