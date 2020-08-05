//
//  MetadataTags.swift
//
//  Created by Stone on 5/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataTags: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case sponsor
        case tagName = "tag_name"
        case sponsored
    }

    var sponsor: String?
    var tagName: String?
    var sponsored: Bool?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.tagName <-- CodingKeys.tagName.rawValue
    }
}
