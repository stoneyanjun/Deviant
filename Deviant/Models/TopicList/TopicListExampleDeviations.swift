//
//  TopicListExampleDeviations.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListExampleDeviations: HandyJSON {

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
        case thumbs
        case category
        case stats
        case preview
        case dailyDeviation = "daily_deviation"
        case isFavourited = "is_favourited"
        case deviationid
        case allowsComments = "allows_comments"
        case title
        case categoryPath = "category_path"
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
    var thumbs: [TopicListThumbs]?
    var category: String?
    var stats: TopicListStats?
    var preview: TopicListPreview?
    var dailyDeviation: TopicListDailyDeviation?
    var isFavourited: Bool?
    var deviationid: String?
    var allowsComments: Bool?
    var title: String?
    var categoryPath: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.isDownloadable <-- CodingKeys.isDownloadable.rawValue
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.publishedTime <-- CodingKeys.publishedTime.rawValue
        mapper <<< self.downloadFilesize <-- CodingKeys.downloadFilesize.rawValue
        mapper <<< self.dailyDeviation <-- CodingKeys.dailyDeviation.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.categoryPath <-- CodingKeys.categoryPath.rawValue
    }
}
