//
//  FavorateInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class FavorateInteractor {
    var presenter: FavoratePresenterInterface?
    private(set) var config: FavorateConfiguration

    init(config: FavorateConfiguration) {
        self.config = config
    }
}

extension FavorateInteractor: FavorateInteractorInterface {
    func tryFetchFavorates() {
        presenter?.setLoadingView(with: true)
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchWhoFavorate()
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            fetchWhoFavorate()
        }
    }
}

extension FavorateInteractor {
    private func fetchWhoFavorate() {
        let offset = 0
        guard let deviationid = config.deviantDetail?.deviationid else {
            return
        }
        let params = WhoFavedParams(deviationid: deviationid,
                                    limit: NetworkConst.limit,
                                    offset: offset)
        NetworkManager<DeviantService>().networkRequest(target: .   whoFaved(params: params)) { result in
            switch result {
            case .success(let json):
                guard let favorateBase = JSONDeserializer<WhoFavorateBase>.deserializeFrom(json: json.description)
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: favorateBase)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
