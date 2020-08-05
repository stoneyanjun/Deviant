//
//  DailyBase.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct DailyBase: HandyJSON {
  enum CodingKeys: String, CodingKey {
    case results
  }

  var results: [DeviantDetailBase]?
}
