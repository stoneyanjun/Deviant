//
//  NetworkDefines.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation

enum RequestConst {
    #if DEBUG
    static let limit = 10
    static let numDeviationsPerTopic = 10
    #else
    static let limit = 10
    static let numDeviationsPerTopic = 10
    #endif
}

enum RequestParams: String {
    case offset
    case limit
    case queryText = "q"
    case timerange
    case clientID = "client_id"
    case clientSecret = "client_secret"

    //Token
    case accessToken = "access_token"
    case grantType = "grant_type"
    case clientCredentials = "client_credentials"

    //categorytree
    case catpath

    //Popular
    case categoryPath = "category_path"

    //topic
    case topic
    case numDeviationsPerTopic = "num_deviations_per_topic"

    //dailydeviations
    case date

    //deviation
    case deviationid
    case rootCatpath = "/"

    //metadata
    case deviationids
    case extSubmission = "ext_submission"
    case extCamera = "ext_camera"
    case extStats = "ext_stats"
    case extCollection = "ext_collection"

    // /browse/morelikethis/preview
    case seed

}

enum ResponseParams: String {
    case errorString = "error"
}
