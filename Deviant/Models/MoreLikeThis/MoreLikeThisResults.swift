//
//  MoreLikeThisResults.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisResults: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case isMature = "is_mature"
        case isDeleted = "is_deleted"
        case categoryPath = "category_path"
        case isDownloadable = "is_downloadable"
        case stats
        case preview
        case category
        case url
        case dailyDeviation = "daily_deviation"
        case deviationid
        case downloadFilesize = "download_filesize"
        case thumbs
        case content
        case publishedTime = "published_time"
        case allowsComments = "allows_comments"
        case author
        case isFavourited = "is_favourited"
        case title
    }

    var isMature: Bool?
    var isDeleted: Bool?
    var categoryPath: String?
    var isDownloadable: Bool?
    var stats: MoreLikeThisStats?
    var preview: MoreLikeThisPreview?
    var category: String?
    var url: String?
    var dailyDeviation: MoreLikeThisDailyDeviation?
    var deviationid: String?
    var downloadFilesize: Int?
    var thumbs: [MoreLikeThisThumbs]?
    var content: MoreLikeThisContent?
    var publishedTime: String?
    var allowsComments: Bool?
    var author: MoreLikeThisAuthor?
    var isFavourited: Bool?
    var title: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue

    }
}

