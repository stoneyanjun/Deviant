//
//  MetadataStats.swift
//
//  Created by Stone on 5/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataStats: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case favourites
        case downloadsToday = "downloads_today"
        case comments
        case downloads
        case viewsToday = "views_today"
        case views
    }

    var favourites: Int?
    var downloadsToday: Int?
    var comments: Int?
    var downloads: Int?
    var viewsToday: Int?
    var views: Int?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.downloadsToday <-- CodingKeys.downloadsToday.rawValue
        mapper <<< self.viewsToday <-- CodingKeys.viewsToday.rawValue
    }
}
