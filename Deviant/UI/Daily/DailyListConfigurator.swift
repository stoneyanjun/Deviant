//
//  DailyListConfigurator.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct DailyListConfigurator {
    let configuration: DailyListConfiguration

    init(config: DailyListConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = DailyListViewController()
        let interactor = DailyListInteractor(with: configuration)
        let presenter = DailyListPresenter()
        let router = DailyListRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}
