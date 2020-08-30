//
//  DeviantService.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import Moya

enum DeviantService {
    case fetchPopular(params: PopularParams)
    case fetchDaily(date: String)
    case fetchDeviantDetail(deviationid: String)
    case fetchTopicList(params: TopicListParams)
    case fetchTopicDetail(params: TopicDetailParams)
    case fetchMetadata(params: MetadataParams)
    case fetchComment(params: CommentParams)
    case fetchUserStatuses(username: String)
    case fetchMoreLikeThisPreview(seed: String)
    case whoFaved(params: WhoFavedParams)
}

extension DeviantService: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: ServerInfoManager.shared.apiPath)!
        }
    }

    var path: String {
        switch self {
        case .fetchPopular:
            return ServerInfoManager.shared.getUri(with: UriResource.browsePopular).wrap()
        case .fetchDaily:
            return ServerInfoManager.shared.getUri(with: UriResource.browseDailydeviations).wrap()
        case .fetchDeviantDetail(let deviationid):
            let pathFormat = ServerInfoManager.shared.getUri(with: UriResource.deviation).wrap()
            guard !pathFormat.isEmpty else {
                return pathFormat
            }
            return String(format: pathFormat, deviationid)
        case .fetchTopicList:
            return ServerInfoManager.shared.getUri(with: UriResource.browseTopics).wrap()
        case .fetchTopicDetail:
            return ServerInfoManager.shared.getUri(with: UriResource.browseTopic).wrap()
        case .fetchMetadata:
            return ServerInfoManager.shared.getUri(with: UriResource.deviationMetadata).wrap()
        case .fetchComment(let params):
            let pathFormat = ServerInfoManager.shared.getUri(with: UriResource.fetchComment).wrap()
            guard !pathFormat.isEmpty else {
                return pathFormat
            }
            return String(format: pathFormat, params.deviationid)
        case .fetchUserStatuses:
            return ServerInfoManager.shared.getUri(with: UriResource.userStatuses).wrap()
        case .fetchMoreLikeThisPreview:
            return ServerInfoManager.shared.getUri(with: UriResource.browseMorelikethisPreview).wrap()
        case .whoFaved:
            return ServerInfoManager.shared.getUri(with: UriResource.whoFaved).wrap()
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .fetchPopular:
            return MockDataManager.shared.getMockData(type: .popularLlist)
        case .fetchTopicList:
            return MockDataManager.shared.getMockData(type: .topicList)
        case .fetchDaily:
            return MockDataManager.shared.getMockData(type: .daily)
        case .fetchTopicDetail:
            return MockDataManager.shared.getMockData(type: .topicDetail)
        case .fetchDeviantDetail:
            return MockDataManager.shared.getMockData(type: .deviantDetail)
        case .fetchMetadata:
            return MockDataManager.shared.getMockData(type: .metadata)
        case .fetchComment:
            return MockDataManager.shared.getMockData(type: .comment)
        case .whoFaved:
            return MockDataManager.shared.getMockData(type: .favorate)
        case .fetchMoreLikeThisPreview:
            return MockDataManager.shared.getMockData(type: .moreLike)
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
        case .fetchPopular(let params):
            var parameters: [String: Any] = [RequestParams.limit.rawValue: params.limit,
                                             RequestParams.offset.rawValue: params.offset,
                                             RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]
            if !params.categoryPath.isEmpty {
                parameters[RequestParams.categoryPath.rawValue] = params.categoryPath
            }
            if !params.query.isEmpty {
                parameters[RequestParams.queryText.rawValue] = params.query
            }
            if !params.timeRange.isEmpty {
                parameters[RequestParams.timerange.rawValue] = params.timeRange
            }

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .fetchDeviantDetail:
            let parameters: [String: Any] = [RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .fetchTopicList(let params):
            let parameters: [String: Any] = [RequestParams.numDeviationsPerTopic.rawValue: params.numDeviationsPerTopic,
                                             RequestParams.limit.rawValue: params.limit,
                                             RequestParams.offset.rawValue: params.offset,
                                             RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .fetchTopicDetail(let params):
            let parameters: [String: Any] = [RequestParams.topic.rawValue: params.name,
                                             RequestParams.limit.rawValue: params.limit,
                                             RequestParams.offset.rawValue: params.offset,
                                             RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .fetchMetadata(let params):
            let parameters: [String: Any] = [RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? "",
                                             RequestParams.deviationids.rawValue: params.deviationids,
                                             RequestParams.extSubmission.rawValue: params.extSubmission,
                                             RequestParams.extCamera.rawValue: params.extCamera ,
                                             RequestParams.extStats.rawValue: params.extStats,
                                             RequestParams.extCollection.rawValue: params.extCollection
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

        case .fetchComment(let params):
            let parameters: [String: Any] = [RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? "",
                                             RequestParams.deviationid.rawValue: params.deviationid,
                                             RequestParams.maxdepth.rawValue: params.maxdepth ?? 0,
                                             RequestParams.offset.rawValue: params.offset,
                                             RequestParams.limit.rawValue: params.limit
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)

        case .fetchUserStatuses(let username):
            let parameters: [String: Any] = [RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? "",
                                             RequestParams.username.rawValue: username ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .fetchMoreLikeThisPreview(let seed):
            let parameters: [String: Any] = [RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? "",
                                             RequestParams.seed.rawValue: seed ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .whoFaved(let params):
            let parameters: [String: Any] = [RequestParams.deviationid.rawValue: params.deviationid,
                                             RequestParams.limit.rawValue: params.limit,
                                             RequestParams.offset.rawValue: params.offset,
                                             RequestParams.accessToken.rawValue: TokenManager.shared.currentToken ?? ""]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
