//
//  NetworkManager.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Alamofire
import Foundation
import Localize_Swift
import Moya
import SwiftyJSON


class NetworkManager<Target: TargetType>: NSObject {
    private var provider = MoyaProvider<Target>()
    private var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    func networkRequest(target: Target, completion: @escaping DeviantApiCallback<JSON>) {
        guard isReachable else { completion(.failure(DeviantError.failure(DeviantGeneralError.networkError)))
            return
        }

        provider.request(target) { result in
            switch result {
            case .success(let response):
                let jsonData = JSON(response.data)
                completion(.success(jsonData))
            case .failure(let err): completion(.failure(DeviantError.failure(DeviantGeneralError.unknownError)))
            }
        }
    }
}

