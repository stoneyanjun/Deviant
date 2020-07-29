//
//  DailyListConfigurator.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct DailyListConfigurator {
    let configuration: DailyListConfiguration

    init(config: DailyListConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = DailyListViewController()
        let interactor = DailyListInteractor(config: configuration)
        let presenter = DailyListPresenter()
        let router = DailyListRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}