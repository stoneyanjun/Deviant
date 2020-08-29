//
//  CommonListPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class CommonListPresenter {
    weak var viewController: CommonListViewControllerInterface?
    var router: CommonListRouterInterface?
}

extension CommonListPresenter: CommonListPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with displayModels: [DeviantDetailDisplayModel], nextOffset: Int) {
        viewController?.update(with: displayModels, nextOffset: nextOffset)
    }

    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        router?.showDeviation(with: deviantDetail)
    }
}
