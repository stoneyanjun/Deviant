//
//  PopularListConfigurator.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct PopularListConfigurator
{
    let configuration: PopularListConfiguration

    init(config: PopularListConfiguration) {
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
