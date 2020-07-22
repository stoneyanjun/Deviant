//
//  TopicListStats.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListStats: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case favourites
    case comments
  }

  var favourites: Int?
  var comments: Int?
}
