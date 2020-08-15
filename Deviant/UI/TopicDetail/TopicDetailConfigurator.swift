//
//  TopicDetailConfigurator.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct TopicDetailConfigurator {
    let configuration: TopicDetailConfiguration

    init(config: TopicDetailConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = TopicDetailViewController()
        let interactor = TopicDetailInteractor(config: configuration)
        let presenter = TopicDetailPresenter()
        let router = TopicDetailRouter()

        viewController.title = configuration.topicName
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.navigationController = configuration.navigationController
        return viewController
    }
}
