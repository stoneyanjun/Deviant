//
//  CommonListConfigurator.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct CommonListConfigurator {
    let configuration: CommonListConfiguration

    init(config: CommonListConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = CommonListViewController()
        let interactor = CommonListInteractor(config: configuration)
        let presenter = CommonListPresenter()
        let router = CommonListRouter()

        viewController.interactor = interactor
        viewController.setListType(with: configuration.listType)
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}
