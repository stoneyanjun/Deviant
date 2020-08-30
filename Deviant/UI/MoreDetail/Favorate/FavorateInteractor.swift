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
    func tryFetchFavorates(offset: Int) {
        presenter?.setLoadingView(with: true)
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchWhoFavorate(offset: offset)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            fetchWhoFavorate(offset: offset)
        }
    }
}

extension FavorateInteractor {
    private func fetchWhoFavorate(offset: Int) {
        let params = WhoFavedParams(deviationid: config.deviationid ,
                                    limit: NetworkConst.limit,
                                    offset: offset)
        NetworkManager<DeviantService>().networkRequest(target: .   whoFaved(params: params)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
                print(#function + " json\r\n\(json.description)")
                #endif
                guard let favorateBase = JSONDeserializer<WhoFavorateBase>.deserializeFrom(json: json.description)
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: favorateBase.results?.map { $0.toDisplayModel() } ?? [],
                                       nextOffset: favorateBase.nextOffset ?? 0)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
