//
//  PopularResults.swift
//
//  Created by Stone on 20/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct PopularResults: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case publishedTime = "published_time"
        case isFavourited = "is_favourited"
        case downloadFilesize = "download_filesize"
        case isMature = "is_mature"
        case isDeleted = "is_deleted"
        case title
        case stats
        case thumbs
        case isDownloadable = "is_downloadable"
        case category
        case allowsComments = "allows_comments"
        case content
        case categoryPath = "category_path"
        case preview
        case author
        case url
        case deviationid
    }

    var publishedTime: String?
    var isFavourited: Bool?
    var downloadFilesize: Int?
    var isMature: Bool?
    var isDeleted: Bool?
    var title: String?
    var stats: PopularStats?
    var thumbs: [PopularThumbs]?
    var isDownloadable: Bool?
    var category: String?
    var allowsComments: Bool?
    var content: PopularContent?
    var categoryPath: String?
    var preview: PopularPreview?
    var author: PopularAuthor?
    var url: String?
    var deviationid: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.publishedTime <-- CodingKeys.publishedTime.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
        mapper <<< self.downloadFilesize <-- CodingKeys.downloadFilesize.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.isDownloadable <-- CodingKeys.isDownloadable.rawValue
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.categoryPath <-- CodingKeys.categoryPath.rawValue
    }
}
