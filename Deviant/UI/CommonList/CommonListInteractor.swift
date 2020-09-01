//
//  CommonListInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class CommonListInteractor {
    var presenter: CommonListPresenterInterface?
    private(set) var config: CommonListConfiguration

    init(with configuration: CommonListConfiguration) {
        config = configuration
    }
}

extension CommonListInteractor: CommonListInteractorInterface {
    func tryFetchList(with offset: Int) {
        presenter?.setLoadingView(with: true)
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fectchList(with: offset)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                    print(#function + " error: \(error.localizedDescription)")
                }
            }
        } else {
            fectchList(with: offset)
        }
    }
}

extension CommonListInteractor {
    private func fectchList(with offset: Int) {
        switch config.listType {
        case .popularList:
            fetchPopular(with: offset)
        case .topicDetail(let topicName):
            fetchTopic(with: topicName, offset: offset)
        }
    }

    private func fetchTopic(with name: String, offset: Int) {
        let params = TopicDetailParams(name: name,
                                       limit: NetworkConst.limit,
                                       offset: offset)
        NetworkManager<DeviantService>().networkRequest(target: .fetchTopicDetail(params: params)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
//                print(#function + " json\r\n\(json.description)")
                #endif
                guard let base = JSONDeserializer<TopicDetailBase>.deserializeFrom(json: json.description),
                    let results = base.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results.map { $0.toDisplayModel() }, nextOffset: base.nextOffset ?? offset)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }

    private func fetchPopular(with offset: Int) {
        let params = PopularParams(categoryPath: "",
                                   query: "",
                                   timeRange: "",
                                   limit: NetworkConst.limit,
                                   offset: offset)
        NetworkManager<DeviantService>().networkRequest(target: .fetchPopular(params: params)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
                    print(#function + " json\r\n\(json.description)")
                #endif
                guard let base = JSONDeserializer<PopularBase>.deserializeFrom(json: json.description),
                    let results = base.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results.map { $0.toDisplayModel() },
                                       nextOffset: base.nextOffset ?? offset)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }

    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        presenter?.showDeviation(with: deviantDetail)
    }
}
