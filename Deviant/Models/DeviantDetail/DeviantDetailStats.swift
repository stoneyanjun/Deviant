//
//  DeviantDetailStats.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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
