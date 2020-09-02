//
//  MetadataBase.swift
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataBase: HandyJSON {
    enum CodingKeys: String, CodingKey {
    case metadata
  }

  var metadata: [MetadataMetadata]?
}
