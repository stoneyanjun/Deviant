//
//  MoreLikeInteractor.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class MoreLikeInteractor {
    var presenter: MoreLikePresenterInterface?
    private(set) var config: MoreLikeConfiguration

    init(config: MoreLikeConfiguration) {
        self.config = config
    }
}

extension MoreLikeInteractor: MoreLikeInteractorInterface {
    func tryFetchMoreLike() {
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchInfo()
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            fetchInfo()
        }
    }
}

extension MoreLikeInteractor {
    private func fetchInfo() {
        self.fetchMoreLike()
        self.fetchUserStatuses()
    }

    private func fetchMoreLike() {
        NetworkManager<DeviantService>().networkRequest(target: .fetchMoreLikeThis(seed: config.deviantDetail?.deviationid ?? "")) { result in
            switch result {
            case .success(let json):
                //                print(#function + "\r\n\(json.description)")
                guard let moreLikeThis = JSONDeserializer<MoreLikeThisBase>.deserializeFrom(json: json.description),
                    let results = moreLikeThis.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.updateMoreLikeThis(with: results)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }

    private func fetchUserStatuses() {
        NetworkManager<DeviantService>().networkRequest(target: .fetchUserStatuses(username: config.deviantDetail?.author?.username ?? "")) { result in
            switch result {
            case .success(let json):
                print(#function + "\r\n\(json.description)")
                guard let userStatus = JSONDeserializer<UserStatusBase>.deserializeFrom(json: json.description),
                    let results = userStatus.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.updateUserStatus(with: results)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
