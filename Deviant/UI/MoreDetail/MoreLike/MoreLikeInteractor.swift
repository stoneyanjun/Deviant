//
//  MoreLikeInteractor.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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
        NetworkManager<DeviantService>().networkRequest(target: .fetchMoreLikeThisPreview(seed: config.deviantDetail?.deviationid ?? "")) { result in
            switch result {
            case .success(let json):
                guard let moreLikeThis = JSONDeserializer<MoreLikeThisPreview>.deserializeFrom(json: json.description),
                    let moreFromDa = moreLikeThis.moreFromDa,
                    let moreFromArtist = moreLikeThis.moreFromArtist
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: moreFromArtist, moreFromDa: moreFromDa)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
