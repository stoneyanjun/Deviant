//
//  TopicDetailResult.swift
//
//  Created by Stone on 1/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicDetailResult: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case preview
        case categoryPath = "category_path"
        case isFavourited = "is_favourited"
        case category
        case publishedTime = "published_time"
        case allowsComments = "allows_comments"
        case stats
        case isDownloadable = "is_downloadable"
        case title
        case dailyDeviation = "daily_deviation"
        case deviationid
        case author
        case isMature = "is_mature"
        case url
        case isDeleted = "is_deleted"
        case downloadFilesize = "download_filesize"
        case content
        case thumbs
    }

    var preview: TopicDetailPreview?
    var categoryPath: String?
    var isFavourited: Bool?
    var category: String?
    var publishedTime: String?
    var allowsComments: Bool?
    var stats: TopicDetailStats?
    var isDownloadable: Bool?
    var title: String?
    var dailyDeviation: TopicDetailDailyDeviation?
    var deviationid: String?
    var author: TopicDetailAuthor?
    var isMature: Bool?
    var url: String?
    var isDeleted: Bool?
    var downloadFilesize: Int?
    var content: TopicDetailContent?
    var thumbs: [TopicDetailThumbs]?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.categoryPath <-- CodingKeys.categoryPath.rawValue
        mapper <<< self.categoryPath <-- CodingKeys.categoryPath.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
        mapper <<< self.publishedTime <-- CodingKeys.publishedTime.rawValue
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.isDownloadable <-- CodingKeys.isDownloadable.rawValue
        mapper <<< self.dailyDeviation <-- CodingKeys.dailyDeviation.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.downloadFilesize <-- CodingKeys.downloadFilesize.rawValue
    }
}
