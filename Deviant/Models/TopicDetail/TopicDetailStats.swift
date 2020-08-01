//
//  TopicDetailStats.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailStats: HandyJSON {

    enum CodingKeys: String, CodingKey {
    case favourites
    case comments
  }

  var favourites: Int?
  var comments: Int?
}
