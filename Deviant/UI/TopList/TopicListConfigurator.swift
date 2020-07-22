//
//  TopicListConfigurator.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct TopicListConfigurator {
    let configuration: TopicListConfiguration

    init(config: TopicListConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = TopicListViewController()
        let interactor = TopicListInteractor(config: configuration)
        let presenter = TopicListPresenter()
        let router = TopicListRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
