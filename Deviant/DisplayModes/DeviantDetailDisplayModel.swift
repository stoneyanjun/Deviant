//
//  DeviantDetailDisplayModel.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

struct ImageInfo {
    var src: String?
    var width: Int?
    var height: Int?
}

struct DeviantDetailDisplayModel {
    var deviationid: String
    var title: String?
    var category: String?
    var excerpt: String?
    var username: String?
    var previewImage: ImageInfo?
    var contentImageInfo: ImageInfo?

    var usericon: String?
    var publishedTime: String?
    var comments: Int?
    var favourites: Int?
}
