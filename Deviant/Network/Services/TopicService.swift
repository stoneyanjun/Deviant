//
//  TopicService.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import Moya

enum TopicService {
    case fetchTopicList(numDeviationsPerTopic : Int, limit: Int, offset: Int)
    case fetchTopicDetail(name : String, limit: Int, offset: Int)
}

extension TopicService: TargetType {
    var baseURL: URL {
        switch self {
            case .fetchTopicList, .fetchTopicDetail:
            return URL(string: ServerInfoManager.shared.apiPath)!
        }
    }

    var path: String {
        switch self {
        case .fetchTopicList:
            return ServerInfoManager.shared.getUri(with: UriResource.browseTopics).wrap()
        case .fetchTopicDetail:
            return ServerInfoManager.shared.getUri(with: UriResource.browseTopic).wrap()
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        default:
            return Date().description.utf8Encoded
        }
    }

    var task: Task {
        switch self {
            case .fetchTopicList(let numDeviationsPerTopic, let limit, let offset):
                var parameters: [String: Any] = [RequestParams.numDeviationsPerTopic.rawValue: numDeviationsPerTopic,
                                                 RequestParams.limit.rawValue: limit,
                                                 RequestParams.offset.rawValue: offset,
                                                 RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            case .fetchTopicDetail(let name, let limit, let offset):
                var parameters: [String: Any] = [RequestParams.topic.rawValue: name,
                                                 RequestParams.limit.rawValue: limit,
                                                 RequestParams.offset.rawValue: offset,
                                                 RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]

                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
