//
//  TopicListInteractor.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class TopicListInteractor {
    var presenter: TopicListPresenterInterface?
    private(set) var config: TopicListConfiguration

    init(config: TopicListConfiguration) {
        self.config = config
    }
}

extension TopicListInteractor: TopicListInteractorInterface {
    func tryFetchTopicList(with offset: Int) {
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchTopicList(with: offset)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            fetchTopicList(with: offset)
        }
    }
}

extension TopicListInteractor {
    private func fetchTopicList(with offset: Int) {
        NetworkManager<TopicService>().networkRequest(target: .fetchTopic(numDeviationsPerTopic: NetworkConst.numDeviationsPerTopic,
                                                                          limit: NetworkConst.limit,
                                                                          offset: offset) ) { result in
            switch result {
            case .success(let json):
                guard let topicListBase = JSONDeserializer<TopicListBase>.deserializeFrom(json: json.description),
                    let results = topicListBase.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results, nextOffset: topicListBase.nextOffset ?? offset)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
