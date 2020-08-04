//
//  MoreLikeThisStats.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisStats: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case favourites
    case comments
  }

  var favourites: Int?
  var comments: Int?
}
