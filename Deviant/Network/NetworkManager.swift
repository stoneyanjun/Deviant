//
//  NetworkManager.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

/*
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
        guard isReachable else {
            completion(.failure(<#T##DeviantError#>))
            return
        }

        provider.request(target) { result in
            switch result {
                case .success(let response):
                    #if DEBUG
                    print(#function + " absoluteString: \(response.request?.url?.absoluteString)")
                    #endif
                    let jsonData = JSON(response.data)
                    print(#function + jsonData.description)
                    if let errorInfo = jsonData[ResponseParams.errorString.rawValue] as? String, !errorInfo.isEmpty {
                        failure?(errorInfo)
                    } else {
                        success(jsonData)
                }
                case .failure(let err):
                    failure?(err.localizedDescription)
            }
        }
    }
}
*/
