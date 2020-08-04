//
//  MetadataConfigurator.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct MetadataConfigurator {
    let configuration: MetadataConfiguration

    init(config: MetadataConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = MetadataViewController()
        let interactor = MetadataInteractor(config: configuration)
        let presenter = MetadataPresenter()
        let router = MetadataRouter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}
