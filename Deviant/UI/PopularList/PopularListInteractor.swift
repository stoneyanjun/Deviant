//
//  PopularListInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class PopularListInteractor {
    var presenter: PopularListPresenterInterface?
    private(set) var config: PopularListConfiguration

    init(config: PopularListConfiguration) {
        self.config = config
    }
}

extension PopularListInteractor: PopularListInteractorInterface {
    func tryFetchPopular(with offset: Int) {
        presenter?.setLoadingView(with: true)
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    print(#function + " success")
                    self.fetchPopular(with: offset)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                    print(#function + " error: \(error.localizedDescription)")
                }
            }
        } else {
            fetchPopular(with: offset)
        }
    }
}

extension PopularListInteractor {
    private func fetchPopular(with offset: Int) {
        let params = PopularParams(categoryPath: "",
                                   query: "",
                                   timeRange: "",
                                   limit: NetworkConst.limit,
                                   offset: offset)
        NetworkManager<DeviantService>().networkRequest(target: .fetchPopular(params: params)) { result in
            switch result {
            case .success(let json):
                print(#function + " success")
                guard let popularBase = JSONDeserializer<PopularBase>.deserializeFrom(json: json.description),
                    let results = popularBase.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results, nextOffset: popularBase.nextOffset ?? offset)
            case .failure(let error):
                self.presenter?.showError(with: error)
                print(#function + " error: \(error.localizedDescription)")
            }
        }
    }

    func showDeviation(with popularResult: DeviantDetailBase) {
        presenter?.showDeviation(with: popularResult)
    }
}
