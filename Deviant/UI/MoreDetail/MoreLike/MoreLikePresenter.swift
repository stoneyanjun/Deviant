//
//  MoreLikePresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class MoreLikePresenter {
    weak var viewController: MoreLikeViewControllerInterface?
    var router: MoreLikeRouterInterface?
}

extension MoreLikePresenter: MoreLikePresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with moreFromArtist: [DeviantDetailDisplayModel], moreFromDa: [DeviantDetailDisplayModel]) {
        viewController?.update(with: moreFromArtist, moreFromDa: moreFromDa)
    }
}
