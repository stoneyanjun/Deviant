//
//  ServiceParams.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

struct PopularParams {
    var categoryPath: String
    var query: String
    var timeRange: String
    var limit: Int
    var offset: Int
}

struct TopicListParams {
    var numDeviationsPerTopic: Int
    var limit: Int
    var offset: Int
}

struct TopicDetailParams {
    var name: String
    var limit: Int
    var offset: Int
}

struct MetadataParams {
    var deviationids: [String]
    var extSubmission: Bool
    var extCamera: Bool
    var extStats: Bool
    var extCollection: Bool
}

struct CommentParams {
    var deviationid: String
    var commentid: String?
    var maxdepth: Int?
    var offset: Int
    var limit: Int
}

struct WhoFavedParams {
    var deviationid: String
    var limit: Int
    var offset: Int
}
