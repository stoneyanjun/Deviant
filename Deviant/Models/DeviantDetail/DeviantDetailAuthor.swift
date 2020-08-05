//
//  DeviantDetailAuthor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailAuthor: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case type
    case usericon
    case userid
    case username
  }

  var type: String?
  var usericon: String?
  var userid: String?
  var username: String?
}
