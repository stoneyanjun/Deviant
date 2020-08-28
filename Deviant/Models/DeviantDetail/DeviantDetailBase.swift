//
//  DeviantDetailBase.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailBase: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case allowsComments = "allows_comments"
        case deviationid
        case author
        case content
        case dailyDeviation = "daily_deviation"
        case url
        case stats
        case isDeleted = "is_deleted"
        case title
        case excerpt
        case isDownloadable = "is_downloadable"
        case isMature = "is_mature"
        case thumbs
        case downloadFilesize = "download_filesize"
        case category
        case preview
        case categoryPath = "category_path"
        case publishedTime = "published_time"
        case isFavourited = "is_favourited"
    }

    var allowsComments: Bool?
    var deviationid: String?
    var author: DeviantUser?
    var content: DeviantDetailContent?
    var dailyDeviation: DeviantDetailDailyDeviation?
    var url: String?
    var stats: DeviantDetailStats?
    var isDeleted: Bool?
    var title: String?
    var excerpt: String?
    var isDownloadable: Bool?
    var isMature: Bool?
    var thumbs: [DeviantDetailThumb]?
    var downloadFilesize: Int?
    var category: String?
    var preview: DeviantDetailPreview?
    var categoryPath: String?
    var publishedTime: String?
    var isFavourited: Bool?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.allowsComments <-- CodingKeys.allowsComments.rawValue
        mapper <<< self.dailyDeviation <-- CodingKeys.dailyDeviation.rawValue
        mapper <<< self.isDeleted <-- CodingKeys.isDeleted.rawValue
        mapper <<< self.isDownloadable <-- CodingKeys.isDownloadable.rawValue
        mapper <<< self.isMature <-- CodingKeys.isMature.rawValue
        mapper <<< self.downloadFilesize <-- CodingKeys.downloadFilesize.rawValue
        mapper <<< self.categoryPath <-- CodingKeys.categoryPath.rawValue
        mapper <<< self.publishedTime <-- CodingKeys.publishedTime.rawValue
        mapper <<< self.isFavourited <-- CodingKeys.isFavourited.rawValue
    }
}

extension DeviantDetailBase {
    func toDisplayModel() -> DeviantDetailDisplayModel {
        var src = ""
        var width: Int?
        var height: Int?
        if let previewSrc = preview?.src,
            !previewSrc.isEmpty {
            src = previewSrc
            width = preview?.width
            height = preview?.height
        } else if let contentSrc = content?.src,
            !contentSrc.isEmpty {
            src = contentSrc
            width = content?.width
            height = content?.height
        } else if let thumbsSrc = thumbs?.first?.src,
            !thumbsSrc.isEmpty {
            src = thumbsSrc
            width = thumbs?.first?.width
            height = thumbs?.first?.height
        }

        return DeviantDetailDisplayModel(deviationid: deviationid.wrap(),
                                         title: title,
                                         category: category,
                                         excerpt: excerpt,
                                         username: author?.username,
                                         src: src,
                                         width: width ,
                                         height: height,
                                         usericon: author?.usericon,
                                         publishedTime: publishedTime,
                                         comments: stats?.comments,
                                         favourites: stats?.favourites)
    }
}
