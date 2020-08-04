//
//  ServiceParams.swift
//  Deviant
//
//  Created by Stone on 2/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation

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
