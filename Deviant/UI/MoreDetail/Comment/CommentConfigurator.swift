//
//  CommentConfigurator.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct CommentConfigurator {
    let configuration: CommentConfiguration

    init(config: CommentConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = CommentViewController()
        let interactor = CommentInteractor(config: configuration)
        let presenter = CommentPresenter()
        let router = CommentRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}