//
//  PopularListConfigurator.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct PopularListConfigurator {
    let configuration: PopularListConfiguration

    init(config: PopularListConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = PopularListViewController()
        let interactor = PopularListInteractor(config: configuration)
        let presenter = PopularListPresenter()
        let router = PopularListRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}
