//
//  MetadataTags.swift
//
//  Created by Stone on 2/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataTags: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case sponsored
        case tagName = "tag_name"
        case sponsor
    }

    var sponsored: Bool?
    var tagName: String?
    var sponsor: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.tagName <-- CodingKeys.tagName.rawValue
    }
}
