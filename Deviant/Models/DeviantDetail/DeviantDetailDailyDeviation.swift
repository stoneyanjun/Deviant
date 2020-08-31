//
//  DeviantDetailDailyDeviation.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailDailyDeviation: HandyJSON {
    enum CodingKeys: String, CodingKey {
    case time
    case giver
    case body
  }

  var time: String?
  var giver: DeviantUser?
  var body: String?
}
