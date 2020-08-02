//
//  MetadataBase.swift
//
//  Created by Stone on 2/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataBase: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case metadata
  }

  var metadata: [MetadataMetadata]?
}
