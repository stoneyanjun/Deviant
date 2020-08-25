//
//  CommentInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class CommentInteractor {
    var presenter: CommentPresenterInterface?
    private(set) var config: CommentConfiguration

    init(config: CommentConfiguration) {
        self.config = config
    }
}

extension CommentInteractor: CommentInteractorInterface {
    func tryFetchComments(offset: Int) {
        presenter?.setLoadingView(with: true)
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchComment(offset: offset)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            fetchComment(offset: offset)
        }
    }
}

extension CommentInteractor {
    private func fetchComment(offset: Int) {
        guard let deviationid = config.deviantDetail?.deviationid else {
            return
        }
        let params = CommentParams(deviationid: deviationid,
                                   commentid: nil,
                                   maxdepth: nil,
                                   offset: offset,
                                   limit: NetworkConst.limit)
        NetworkManager<DeviantService>().networkRequest(target: .   fetchComment(params: params)) { result in
            switch result {
            case .success(let json):
                print(json.description)
                guard let comment = JSONDeserializer<CommentBase>.deserializeFrom(json: json.description)
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: comment)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
