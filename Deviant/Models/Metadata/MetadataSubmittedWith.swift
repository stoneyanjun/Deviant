//
//  MetadataSubmittedWith.swift
//
//  Created by Stone on 5/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataSubmittedWith: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case url
    case app
  }

  var url: String?
  var app: String?
}
