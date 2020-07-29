//
//  BrowseService.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import Moya

enum BrowseService {
    case fetchPopular(categoryPath: String, query: String, timeRange: String, limit: Int, offset: Int)
    case fetchDaily(date: String)
}

extension BrowseService: TargetType {
    var baseURL: URL {
        switch self {
        case .fetchPopular, .fetchDaily:
            return URL(string: ServerInfoManager.shared.apiPath)!
        }
    }

    var path: String {
        switch self {
        case .fetchPopular:
            return ServerInfoManager.shared.getUri(with: UriResource.browsePopular).wrap()
        case .fetchDaily:
            return ServerInfoManager.shared.getUri(with: UriResource.browseDailydeviations).wrap()
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
        case .fetchDaily(let date):
            var parameters: [String: Any] = [RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]
            if !date.isEmpty {
                parameters[RequestParams.date.rawValue] = date
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .fetchPopular(let categoryPath, let query, let timeRange, let limit, let offset):
            var parameters: [String: Any] = [RequestParams.limit.rawValue: limit,
                                             RequestParams.offset.rawValue: offset,
                                             RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]
            if !categoryPath.isEmpty {
                parameters[RequestParams.categoryPath.rawValue] = categoryPath
            }
            if !query.isEmpty {
                parameters[RequestParams.queryText.rawValue] = query
            }
            if !timeRange.isEmpty {
                parameters[RequestParams.timerange.rawValue] = timeRange
            }

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
