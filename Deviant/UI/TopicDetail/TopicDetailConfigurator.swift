//
//  TopicDetailConfigurator.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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
        return viewController
    }
}
