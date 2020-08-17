//
//  ServerInfoManager.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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
    case userStatuses
    case moreLikeThisPreview
    case whoFaved
}

class ServerInfoManager {
    private enum InfoKey: String {
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
    private var pathInfo = [String: String]()

    private init() {
        loadUris()
        loadClientInfo()
        loadServerInfo()
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
        let serverInfo: [String: String] = requestDict
        serverBaseUrl = serverInfo[InfoKey.serverBaseURL.rawValue].wrap()
        apiPath = serverBaseUrl + serverInfo[InfoKey.apiBasePath.rawValue].wrap()
    }

    private func loadClientInfo() {
        guard let filtPath = Bundle.main.path(forResource: "Client", ofType: "plist"),
            let requestDict = NSDictionary(contentsOfFile: filtPath) as? [String: String] else {
                return
        }
        let clientInfo: [String: String] = requestDict
        clientID = clientInfo[InfoKey.clientID.rawValue].wrap()
        clientSecret = clientInfo[InfoKey.clientSecret.rawValue].wrap()
    }
}
