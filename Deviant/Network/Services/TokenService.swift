//
//  TokenService.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import Moya

enum TokenService {
    case fetchToken(clientID: String, clientSecret: String)
}

extension TokenService: TargetType {
    var baseURL: URL {
        switch self {
        case .fetchToken:
            print(#function + ServerInfoManager.shared.serverBaseUrl)
            return URL(string: ServerInfoManager.shared.serverBaseUrl)!
        }
    }

    var path: String {
        switch self {
        case .fetchToken:
            print(#function + ServerInfoManager.shared.getUri(with: UriResource.oauth2Token).wrap())
        return ServerInfoManager.shared.getUri(with: UriResource.oauth2Token).wrap()
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .fetchToken:
            return Date().description.utf8Encoded
        }
    }

    var task: Task {
        switch self {
        case .fetchToken(let clientID, let clientSecret):
            let parameters: [String: Any] = [RequestParams.grantType.rawValue: RequestParams.clientCredentials.rawValue,
                                             RequestParams.clientID.rawValue: clientID,
                                             RequestParams.clientSecret.rawValue: clientSecret]

            print(#function + " \r\n \(parameters)")
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
