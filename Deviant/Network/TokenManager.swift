//
//  TokenManager.swift
//  Deviant
//
//  Created by Stone on 17/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import HandyJSON

typealias DeviantApiCallback<T> = (_ result: Result<T, DeviantError>) -> Void

class TokenManager {
    static let shared = TokenManager()
    private var token: String?
    private var expiredTime: Date?
    private var provider = Moya.MoyaProvider<TokenService>()

    var currentToken: String? {
        guard let token = self.token,
            !token.isEmpty,
            !isTokenExpried() else {
                return nil
        }
        return token
    }

    private init() {
    }

    func needFetchToken() -> Bool {
        return currentToken == nil
    }

    func fetchToken(completion: @escaping DeviantApiCallback<TokenBase>) {
        let clientID = ServerInfoManager.shared.clientID.wrap()
        let clientSecret = ServerInfoManager.shared.clientSecret.wrap()
        guard !(clientID.isEmpty || clientSecret.isEmpty) else {
            completion(.failure(DeviantError.failure(DeviantGeneralError.accountError)))
            return
        }

        provider.request(
            TokenService.fetchToken(
                clientID: clientID,
                clientSecret: clientSecret)) { result in
                    switch result {
                    case .success(let response):
                        let jsonData = JSON(response.data)
                        if let base = JSONDeserializer<TokenBase>.deserializeFrom(json:jsonData.description ) {
                            if let token = base.accessToken, !token.isEmpty { completion(.success(base))
                                return
                            }
                    }
                    default:
                        break
                    }
                    completion(.failure(DeviantError.failure(DeviantGeneralError.accountError)))
        }
    }
}

extension TokenManager {
    private func isTokenExpried() -> Bool {
        guard let expiredTime = self.expiredTime else {
            return false
        }
        return Date() < expiredTime
    }
}


