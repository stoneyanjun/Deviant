//
//  TopicDetailInteractor.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class TopicDetailInteractor {
    var presenter: TopicDetailPresenterInterface?
    private(set) var config: TopicDetailConfiguration

    init(config: TopicDetailConfiguration) {
        self.config = config
    }
}

extension TopicDetailInteractor: TopicDetailInteractorInterface {
    func tryFetchTopicDetail(with offset: Int) {
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchTopicDetail(offset: offset)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            fetchTopicDetail(offset: offset)
        }
    }
}

extension TopicDetailInteractor {
    private func fetchTopicDetail(offset: Int) {
        NetworkManager<TopicService>().networkRequest(target: .fetchTopicDetail(name: config.topicName, limit: NetworkConst.limit, offset: offset)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
                #endif
                /*
                guard let popularBase = JSONDeserializer<TopicDetailBase>.deserializeFrom(json: json.description),
                    let results = popularBase.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results, nextOffset: popularBase.nextOffset ?? offset)
                */
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
