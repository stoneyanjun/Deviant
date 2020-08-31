//
//  TopicListConfigurator.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct TopicListConfigurator {
    let configuration: TopicListConfiguration

    init(config: TopicListConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = TopicListViewController()
        let interactor = TopicListInteractor(with: configuration)
        let presenter = TopicListPresenter()
        let router = TopicListRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}
