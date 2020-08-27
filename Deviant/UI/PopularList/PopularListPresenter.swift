//
//  PopularListPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class PopularListPresenter {
    weak var viewController: PopularListViewControllerInterface?
    var router: PopularListRouterInterface?
}

extension PopularListPresenter: PopularListPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with displayModels: [DeviantDetailDisplay], nextOffset: Int) {
        viewController?.update(with: displayModels, nextOffset: nextOffset)
    }

    func showDeviation(with deviantDetail: DeviantDetailDisplay) {
        router?.showDeviation(with: deviantDetail)
    }
}
