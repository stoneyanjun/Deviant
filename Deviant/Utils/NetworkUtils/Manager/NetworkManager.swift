//
//  NetworkManager.swift
//  Deviant
//
//  Created by stone on 2020/7/5.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

enum MoyaResult<T> {
    case success(T)
    case failure(Error)
}

class NetworkManager<Target: TargetType>: NSObject {

    typealias MoyaCompletion = (MoyaResult<Data>) -> Void

    private var provider = MoyaProvider<Target>()
    private var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    func request(target: Target, completion: @escaping MoyaCompletion) {
        guard isReachable else {
            completion(.failure(DevinatError(errorCode: "-1", errorDescription: "Network not available!")))
            return
        }

        provider.request(target) { (result) in
            switch result {
                case .success(let response):
                    let jsonData = JSON(response.data)
                    #if DEBUG
                    print(#function + "jsonData: \r\n \(jsonData.description)")
                    #endif
                    if let errorInfo = jsonData[ResponseParams.error.rawValue] as? String, !errorInfo.isEmpty {
                        completion(DevinatError(errorCode: errorInfo, errorDescription: nil)
                    }
                    break
                case .failure(let error):
                    break
            }
        }
    }
}
