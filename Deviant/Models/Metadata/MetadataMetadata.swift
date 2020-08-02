//
//  MetadataMetadata.swift
//
//  Created by Stone on 2/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataMetadata: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case tags
        case license
        case isWatching = "is_watching"
        case allowsComments = "allows_comments"
        case isFavourited = "is_favourited"
        case title
        case descriptionValue = "description"
        case author
        case isMature = "is_mature"
        case deviationid
    }

    var tags: [MetadataTags]?
    var license: String?
    var isWatching: Bool?
    var allowsComments: Bool?
    var isFavourited: Bool?
    var title: String?
    var descriptionValue: String?
    var author: MetadataAuthor?
    var isMature: Bool?
    var deviationid: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.isWatching <-- CodingKeys.isWatching.rawValue
        mapper <<< self.isWatching <-- CodingKeys.isWatching.rawValue
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
        mapper <<< self.descriptionValue <-- CodingKeys.descriptionValue.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
    }
}
