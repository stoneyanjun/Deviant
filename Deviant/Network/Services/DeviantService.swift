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

    var currentParameters: [String: Any]? {
        var parameters = [String: Any]()
        switch self {
        case .fetchDaily(let date):
            if !date.isEmpty {
                parameters[RequestParams.date.rawValue] = date
            }
        case .fetchPopular(let params):
            parameters = [RequestParams.limit.rawValue: params.limit,
                          RequestParams.offset.rawValue: params.offset]
            if !params.categoryPath.isEmpty {
                parameters[RequestParams.categoryPath.rawValue] = params.categoryPath
            }
            if !params.query.isEmpty {
                parameters[RequestParams.queryText.rawValue] = params.query
            }
            if !params.timeRange.isEmpty {
                parameters[RequestParams.timerange.rawValue] = params.timeRange
            }
        case .fetchTopicList(let params):
            parameters = [RequestParams.numDeviationsPerTopic.rawValue: params.numDeviationsPerTopic,
                          RequestParams.limit.rawValue: params.limit,
                          RequestParams.offset.rawValue: params.offset]
        case .fetchTopicDetail(let params):
            parameters = [RequestParams.topic.rawValue: params.name,
                          RequestParams.limit.rawValue: params.limit,
                          RequestParams.offset.rawValue: params.offset]
        case .fetchMetadata(let params):
            parameters = [RequestParams.deviationids.rawValue: params.deviationids,
                          RequestParams.extSubmission.rawValue: params.extSubmission,
                          RequestParams.extCamera.rawValue: params.extCamera ,
                          RequestParams.extStats.rawValue: params.extStats,
                          RequestParams.extCollection.rawValue: params.extCollection]
        case .fetchComment(let params):
            parameters = [RequestParams.deviationid.rawValue: params.deviationid,
                          RequestParams.maxdepth.rawValue: params.maxdepth ?? 0,
                          RequestParams.offset.rawValue: params.offset,
                          RequestParams.limit.rawValue: params.limit]
        case .fetchUserStatuses(let username):
            parameters = [RequestParams.username.rawValue: username]
        case .fetchMoreLikeThisPreview(let seed):
            parameters = [RequestParams.seed.rawValue: seed ]
        case .whoFaved(let params):
            parameters = [RequestParams.deviationid.rawValue: params.deviationid,
                          RequestParams.limit.rawValue: params.limit,
                          RequestParams.offset.rawValue: params.offset]
        default:
            return nil
        }

        parameters[RequestParams.accessToken.rawValue] =  TokenManager.shared.currentToken ?? ""
        //stonetest
        parameters[RequestParams.accessToken.rawValue] = "asd"
        return parameters
    }

    var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.queryString
        }
        if let requestParameters = currentParameters {
            return .requestParameters(parameters: requestParameters, encoding: encoding)
        }
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
