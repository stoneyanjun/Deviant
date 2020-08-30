//
//  MoreLikeInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class MoreLikeInteractor {
    var presenter: MoreLikePresenterInterface?
    private(set) var config: MoreLikeConfiguration

    init(config: MoreLikeConfiguration) {
        self.config = config
    }
}

extension MoreLikeInteractor: MoreLikeInteractorInterface {
    func tryFetchMoreLike() {
        presenter?.setLoadingView(with: true)
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchMoreLike()
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            fetchMoreLike()
        }
    }
}

extension MoreLikeInteractor {
    private func fetchMoreLike() {
        NetworkManager<DeviantService>().networkRequest(target:
        .fetchMoreLikeThisPreview(seed: config.deviationid)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
                print(#function + " json\r\n\(json.description)")
                #endif
                guard let moreLikeThis = JSONDeserializer<MoreLikeThisPreview>.deserializeFrom(json: json.description),
                    let moreFromDa = moreLikeThis.moreFromDa,
                    let moreFromArtist = moreLikeThis.moreFromArtist
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: moreFromArtist.map { $0.toDisplayModel() },
                                       moreFromDa: moreFromDa.map { $0.toDisplayModel() })
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
