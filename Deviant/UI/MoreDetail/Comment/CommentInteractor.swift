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

    init(with configuration: CommentConfiguration) {
        config = configuration
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
        let params = CommentParams(deviationid: config.deviationid,
                                   commentid: nil,
                                   maxdepth: nil,
                                   offset: offset,
                                   limit: NetworkConst.commentLimit)
        NetworkManager<DeviantService>().networkRequest(target: .   fetchComment(params: params)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
//                print(#function + " json\r\n\(json.description)")
                #endif
                guard let comment = JSONDeserializer<CommentBase>.deserializeFrom(json: json.description)
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: comment.thread?.map { $0.toDisplayModel() } ?? [],
                                       nextOffset: comment.nextOffset ?? 0)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
