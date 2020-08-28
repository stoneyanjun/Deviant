//
//  FavoratePresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class FavoratePresenter {
    weak var viewController: FavorateViewControllerInterface?
    var router: FavorateRouterInterface?
}

extension FavoratePresenter: FavoratePresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with favorates: [FavorateDisplayModel], nextOffset: Int) {
        viewController?.update(with: favorates, nextOffset: nextOffset)
    }
}
