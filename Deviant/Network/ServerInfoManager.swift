//
//  ServerInfoManager.swift
//  Deviant
//
//  Created by Stone on 17/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation

enum UriResource: String {
    case oauth2Token
    case browsePopular
    case browseTopics
    case browseTopic
    case browseDailydeviations
    case deviation
    case userProfile
    case deviationMetadata
    case fetchComment
}

class ServerInfoManager {
    private enum ServerInfoKey: String {
        case clientID = "ClientID"
        case clientSecret = "ClientSecret"
        case serverBaseURL = "ServerBaseURL"
        case apiBasePath = "APIBasePath"
    }

    static let shared = ServerInfoManager()

    private(set) var serverBaseUrl: String = ""
    private(set) var apiPath: String = ""
    private(set) var clientID: String = ""
    private(set) var clientSecret: String = ""

    private var serverInfo = [String: String]()
    private var pathInfo = [String: String]()

    private init() {
        loadUris()
        loadServerInfo()
    }

    private func getServerInfo(with infoKey: ServerInfoKey) -> String? {
        return serverInfo[infoKey.rawValue]
    }

    func getUri(with resource: UriResource) -> String? {
        return pathInfo[resource.rawValue]
    }
}

extension ServerInfoManager {
    private func loadUris() {
        guard let filtPath = Bundle.main.path(forResource: "Request", ofType: "plist"),
            let requestDict = NSDictionary(contentsOfFile: filtPath) as? [String: String] else {
                return
        }
        pathInfo = requestDict
    }

    private func loadServerInfo() {
        guard let filtPath = Bundle.main.path(forResource: "ServerInfo", ofType: "plist"),
            let requestDict = NSDictionary(contentsOfFile: filtPath) as? [String: String] else {
                return
        }
        serverInfo = requestDict
        serverBaseUrl = serverInfo[ServerInfoKey.serverBaseURL.rawValue].wrap()
        apiPath = serverBaseUrl + serverInfo[ServerInfoKey.apiBasePath.rawValue].wrap()
        clientID = serverInfo[ServerInfoKey.clientID.rawValue].wrap()
        clientSecret = serverInfo[ServerInfoKey.clientSecret.rawValue].wrap()
    }
}
