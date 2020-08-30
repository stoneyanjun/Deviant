//
//  TopicListInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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
        presenter?.setLoadingView(with: true)
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
        let params = TopicListParams(numDeviationsPerTopic: NetworkConst.numDeviationsPerTopic,
                                     limit: NetworkConst.limit,
                                     offset: offset)
        NetworkManager<DeviantService>().networkRequest(target: .fetchTopicList(params: params) ) { result in
            switch result {
            case .success(let json):
                #if DEBUG
                print(#function + " json\r\n\(json.description)")
                #endif
                guard let topicListBase = JSONDeserializer<TopicListBase>.deserializeFrom(json: json.description),
                    let results = topicListBase.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results.map{ $0.toDisplayModel() } , nextOffset: topicListBase.nextOffset ?? offset)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }

    func showTopic(with topicName: String) {
        self.presenter?.showTopic(with: topicName)
    }

    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        self.presenter?.showDeviation(with: deviantDetail)
    }
}
