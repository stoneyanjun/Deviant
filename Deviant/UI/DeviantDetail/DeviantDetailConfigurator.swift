//
//  DeviantDetailConfigurator.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct DeviantDetailConfigurator {
    let configuration: DeviantDetailConfiguration

    init(config: DeviantDetailConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = DeviantDetailViewController()
        let interactor = DeviantDetailInteractor(with: configuration)
        let presenter = DeviantDetailPresenter()
        let router = DeviantDetailRouter()

        viewController.title = configuration.detailParams.title.wrap()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
