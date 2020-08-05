//
//  MoreLikePresenter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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

    func update(with moreFromArtist: [DeviantDetailBase], moreFromDa: [DeviantDetailBase]) {
        viewController?.update(with: moreFromArtist, moreFromDa: moreFromDa)
    }
}
