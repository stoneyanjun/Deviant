//
//  NetworkManager.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Alamofire
import Foundation
import HandyJSON
import Localize_Swift
import Moya
import SwiftyJSON

class NetworkManager<Target: TargetType>: NSObject {
    private var provider = MoyaProvider<Target>()
    private var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

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
