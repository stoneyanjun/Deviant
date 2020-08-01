//
//  TopicListDeviation.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListDeviation: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case isDownloadable = "is_downloadable"
        case isDeleted = "is_deleted"
        case url
        case isMature = "is_mature"
        case publishedTime = "published_time"
        case downloadFilesize = "download_filesize"
        case printid
        case author
        case content
        case category
        case thumbs
        case stats
        case preview
        case dailyDeviation = "daily_deviation"
        case deviationid
        case title
        case categoryPath = "category_path"
        case allowsComments = "allows_comments"
        case isFavourited = "is_favourited"
    }

    var isDownloadable: Bool?
    var isDeleted: Bool?
    var url: String?
    var isMature: Bool?
    var publishedTime: String?
    var downloadFilesize: Int?
    var printid: String?
    var author: TopicListAuthor?
    var content: TopicListContent?
    var category: String?
    var thumbs: [TopicListThumbs]?
    var stats: TopicListStats?
    var preview: TopicListPreview?
    var dailyDeviation: TopicListDailyDeviation?
    var deviationid: String?
    var title: String?
    var categoryPath: String?
    var allowsComments: Bool?
    var isFavourited: Bool?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.isDownloadable <-- CodingKeys.isDownloadable.rawValue
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.publishedTime <-- CodingKeys.publishedTime.rawValue
        mapper <<< self.downloadFilesize <-- CodingKeys.downloadFilesize.rawValue
        mapper <<< self.dailyDeviation <-- CodingKeys.dailyDeviation.rawValue
        mapper <<< self.categoryPath <-- CodingKeys.categoryPath.rawValue
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
    }
}
