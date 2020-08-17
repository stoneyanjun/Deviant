//
//  MetadataMetadata.swift
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataMetadata: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case tags
        case deviationid
        case descriptionValue = "description"
        case stats
        case allowsComments = "allows_comments"
        case isMature = "is_mature"
        case isFavourited = "is_favourited"
        case title
        case license
        case isWatching = "is_watching"
        case author
        case submission
    }

    var tags: [MetadataTags]?
    var deviationid: String?
    var descriptionValue: String?
    var stats: MetadataStats?
    var allowsComments: Bool?
    var isMature: Bool?
    var isFavourited: Bool?
    var title: String?
    var license: String?
    var isWatching: Bool?
    var author: DeviantUser?
    var submission: MetadataSubmission?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.descriptionValue <-- CodingKeys.descriptionValue.rawValue
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
        mapper <<< self.isWatching <-- CodingKeys.isWatching.rawValue
    }
}
