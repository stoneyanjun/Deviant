//
//  NetworkManager.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Alamofire
import Foundation
import HandyJSON
import Moya
import SwiftyJSON

enum DeviantUITestsMode: String {
    case deviantUITestMode
}

class NetworkManager<Target: TargetType>: NSObject {
    private var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    private var provider: MoyaProvider<Target> = {
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains(DeviantUITestsMode.deviantUITestMode.rawValue) {
            return MoyaProvider<Target>(stubClosure: MoyaProvider<Target>.delayedStub(NetworkConst.delayedStubTime))
        } else {
            return MoyaProvider<Target>()
        }
    }()

    func networkRequest(target: Target, completion: @escaping DeviantApiCallback<JSON>) {
        guard isReachable else { completion(.failure(DeviantFailure.devFailure(DeviantGeneralError.networkError)))
            return
        }

        provider.request(target) { result in
            switch result {
            case .success(let response):
                let jsonData = JSON(response.data)
                if let apiError = JSONDeserializer<APIError>.deserializeFrom(json: jsonData.description),
                    let error = apiError.error,
                    !error.isEmpty {
                    let generalError = DeviantGeneralError(errorType: .unknown,
                                                           error: error,
                                                           errorDescription: apiError.errorDescription)
                    completion(.failure(DeviantFailure.devFailure(generalError)))
                } else {
                    completion(.success(jsonData))
                }
            case .failure:
                completion(.failure(DeviantFailure.devFailure(DeviantGeneralError.networkError)))
            }
        }
    }
}
