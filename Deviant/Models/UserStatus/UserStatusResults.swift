//
//  UserStatusResults.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusResults: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case isDeleted = "is_deleted"
        case author
        case isShare = "is_share"
        case url
        case body
        case ts
        case statusid
        case items
        case commentsCount = "comments_count"
    }

    var isDeleted: Bool?
    var author: UserStatusAuthor?
    var isShare: Bool?
    var url: String?
    var body: String?
    var ts: String?
    var statusid: String?
    var items: [UserStatusItems]?
    var commentsCount: Int?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.isShare <-- CodingKeys.isShare.rawValue
        mapper <<< self.commentsCount <-- CodingKeys.commentsCount.rawValue
    }
}
