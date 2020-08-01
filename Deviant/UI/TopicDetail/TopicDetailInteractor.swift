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
    func tryFetchTopic(with offset: Int) {
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchTopic(with: self.config.topicName, offset: offset)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            self.fetchTopic(with: config.topicName, offset: offset)
        }
    }
}

extension TopicDetailInteractor {
    private func fetchTopic(with name: String, offset: Int) {
        NetworkManager<TopicService>().networkRequest(target: .fetchTopicDetail(name: name, limit: NetworkConst.limit, offset: offset)) { result in
            switch result {
            case .success(let json):
                guard let topicDetailBase = JSONDeserializer<TopicDetailBase>.deserializeFrom(json: json.description),
                    let results = topicDetailBase.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results, nextOffset: topicDetailBase.nextOffset ?? offset)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }

    func showDeviation(with topicDetail: TopicDetailResult) {
        presenter?.showDeviation(with: topicDetail)
    }
}
