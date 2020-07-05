//
//  PopularListConfigurator.swift
//  Deviant
//
//  Created by stone on 2020/7/5.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct PopularListConfig
{
}

struct PopularListConfigurator
{
    let configuration: PopularListConfig

    init(config: PopularListConfig) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let vc = PopularListViewController()
        let interactor = PopularListInteractor(config: configuration)
        let presenter = PopularListPresenter()
        let router = PopularListRouter()

        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = vc
        router.viewController = vc
        return vc
    }
}
