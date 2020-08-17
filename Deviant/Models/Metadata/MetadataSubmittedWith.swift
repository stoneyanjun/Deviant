//
//  MetadataSubmittedWith.swift
//
//  Copyright © 2020 Stone. All rights reserved.
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
