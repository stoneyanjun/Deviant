//
//  DailyListPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class DailyListPresenter {
    weak var viewController: DailyListViewControllerInterface?
    var router: DailyListRouterInterface?
}

extension DailyListPresenter: DailyListPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with results: [DeviantDetailBase]) {
        viewController?.update(with: results)
    }

    func showDeviation(with dailyResult: DeviantDetailBase) {
        router?.showDeviation(with: dailyResult)
    }
}
