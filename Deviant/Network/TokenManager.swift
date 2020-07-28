//
//  TokenManager.swift
//  Deviant
//
//  Created by Stone on 17/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import HandyJSON
import Moya
import SwiftyJSON

typealias DeviantApiCallback<T> = (_ result: Result<T, DeviantFailure>) -> Void

class TokenManager: NetworkManager<TokenService> {
    static let shared = TokenManager()
    private var tokenBase: TokenBase?
    private var tokenExpiredDate: Date?

    var currentToken: String? {
        guard let accessToken = self.tokenBase?.accessToken,
            !accessToken.isEmpty,
            !isTokenExpried() else {
                return nil
        }
        return accessToken
    }

    override private init() {
    }

    func needFetchToken() -> Bool {
        return currentToken == nil
    }

    func fetchToken(completion: @escaping DeviantApiCallback<String>) {
        clearTokenInfo()

        let clientID = ServerInfoManager.shared.clientID
        let clientSecret = ServerInfoManager.shared.clientSecret
        guard !(clientID.isEmpty || clientSecret.isEmpty) else {
            completion(.failure(DeviantFailure.devFailure(DeviantGeneralError.oauthError)))
            return
        }

        networkRequest(target: .fetchToken(clientID: clientID, clientSecret: clientSecret)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
                print(#function + " json\r\n\(json.description)")
                #endif
                if let tokenBase = JSONDeserializer<TokenBase>.deserializeFrom(json: json.description ), !tokenBase.accessToken.wrap().isEmpty {
                    self.tokenBase = tokenBase
                    let timeInterval = TimeInterval(tokenBase.expiresIn ?? NetworkConst.defaultExpiredSecond)
                    self.tokenExpiredDate = Date().addingTimeInterval(timeInterval)
                    completion(.success(tokenBase.accessToken.wrap()))
                } else {
                    completion(.failure(DeviantFailure.devFailure(DeviantGeneralError.oauthError)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension TokenManager {
    private func clearTokenInfo() {
        tokenBase = nil
        tokenExpiredDate = nil
    }

    private func isTokenExpried() -> Bool {
        guard let tokenExpiredDate = self.tokenExpiredDate else {
            return true
        }

        return Date() > tokenExpiredDate
    }
}
