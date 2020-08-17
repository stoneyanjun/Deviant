//
//  FavorateConfigurator.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct FavorateConfigurator {
    let configuration: FavorateConfiguration

    init(config: FavorateConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = FavorateViewController()
        let interactor = FavorateInteractor(config: configuration)
        let presenter = FavoratePresenter()
        let router = FavorateRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}
