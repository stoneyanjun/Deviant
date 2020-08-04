//
//  MoreLikeConfigurator.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct MoreLikeConfigurator {
    let configuration: MoreLikeConfiguration

    init(config: MoreLikeConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = MoreLikeViewController()
        let interactor = MoreLikeInteractor(config: configuration)
        let presenter = MoreLikePresenter()
        let router = MoreLikeRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}
