//
//  PopularListVCConfigurator.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

struct PopularListVCConfigurator
{
    let configuration: PopularListVCConfiguration

    init(config: PopularListVCConfiguration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let vc = PopularListVCViewController()
        let interactor = PopularListVCInteractor(config: configuration)
        let presenter = PopularListVCPresenter()
        let router = PopularListVCRouter()

        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = vc
        router.viewController = vc
        return vc
    }
}
