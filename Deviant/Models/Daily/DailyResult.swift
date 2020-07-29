//
//  DailyResult.swift
//
//  Created by Stone on 29/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct DailyResult: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case thumbs
        case categoryPath = "category_path"
        case deviationid
        case author
        case isDeleted = "is_deleted"
        case category
        case isFavourited = "is_favourited"
        case isDownloadable = "is_downloadable"
        case stats
        case url
        case allowsComments = "allows_comments"
        case title
        case content
        case dailyDeviation = "daily_deviation"
        case preview
        case excerpt
        case downloadFilesize = "download_filesize"
        case isMature = "is_mature"
        case publishedTime = "published_time"
    }

    var thumbs: [DailyThumbs]?
    var categoryPath: String?
    var deviationid: String?
    var author: DailyAuthor?
    var isDeleted: Bool?
    var category: String?
    var isFavourited: Bool?
    var isDownloadable: Bool?
    var stats: DailyStats?
    var url: String?
    var allowsComments: Bool?
    var title: String?
    var content: DailyContent?
    var dailyDeviation: DailyDailyDeviation?
    var preview: DailyPreview?
    var excerpt: String?
    var downloadFilesize: Int?
    var isMature: Bool?
    var publishedTime: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.categoryPath <-- CodingKeys.categoryPath.rawValue
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
        mapper <<< self.isDownloadable <-- CodingKeys.isDownloadable.rawValue
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.dailyDeviation <-- CodingKeys.dailyDeviation.rawValue
        mapper <<< self.downloadFilesize <-- CodingKeys.downloadFilesize.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.publishedTime <-- CodingKeys.publishedTime.rawValue
    }
}
