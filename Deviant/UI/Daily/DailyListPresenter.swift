//
//  DailyListPresenter.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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
}
