//
//  UserStatusDeviation.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct UserStatusDeviation: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case preview
    case deviationid
    case content
    case stats
    case publishedTime = "published_time"
    case isDownloadable = "is_downloadable"
    case author
    case isFavourited = "is_favourited"
    case title
    case allowsComments = "allows_comments"
    case thumbs
    case url
    case downloadFilesize = "download_filesize"
    case isMature = "is_mature"
    case isDeleted = "is_deleted"
    case category
    case categoryPath = "category_path"
  }

  var preview: UserStatusPreview?
  var deviationid: String?
  var content: UserStatusContent?
  var stats: UserStatusStats?
  var publishedTime: String?
  var isDownloadable: Bool?
  var author: UserStatusAuthor?
  var isFavourited: Bool?
  var title: String?
  var allowsComments: Bool?
  var thumbs: [UserStatusThumbs]?
  var url: String?
  var downloadFilesize: Int?
  var isMature: Bool?
  var isDeleted: Bool?
  var category: String?
  var categoryPath: String?
}
