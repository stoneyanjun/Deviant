//
//  MetadataPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class MetadataPresenter {
    weak var viewController: MetadataViewControllerInterface?
    var router: MetadataRouterInterface?
}

extension MetadataPresenter: MetadataPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with meta: MetadataBase) {
        viewController?.update(with: meta)
    }
}
