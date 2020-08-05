//
//  PopularListPresenter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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

    func update(with results: [DeviantDetailBase], nextOffset: Int) {
        viewController?.update(with: results, nextOffset: nextOffset)
    }

    func showDeviation(with popularResult: DeviantDetailBase) {
        router?.showDeviation(with: popularResult)
    }
}
