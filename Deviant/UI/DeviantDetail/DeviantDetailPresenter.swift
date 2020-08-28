//
//  DeviantDetailPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class DeviantDetailPresenter {
    weak var viewController: DeviantDetailViewControllerInterface?
    var router: DeviantDetailRouterInterface?
}

extension DeviantDetailPresenter: DeviantDetailPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with deviantDetail: DeviantDetailDisplayModel) {
        viewController?.update(with: deviantDetail)
    }

    func showMoreDetail(with deviantDetail: DeviantDetailDisplayModel, tag: Int) {
        router?.showMoreDetail(with: deviantDetail, tag: tag)
    }
}
