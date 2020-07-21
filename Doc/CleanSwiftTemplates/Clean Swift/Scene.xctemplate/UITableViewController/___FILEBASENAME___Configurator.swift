//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ___VARIABLE_sceneName___Configurator {
    let configuration: ___VARIABLE_sceneName___Configuration

    init(config: ___VARIABLE_sceneName___Configuration) {
        configuration = config
    }

    func createViewController() -> UIViewController {
        let viewController = ___VARIABLE_sceneName___ViewController()
        let interactor = ___VARIABLE_sceneName___Interactor(config: configuration)
        let presenter = ___VARIABLE_sceneName___Presenter()
        let router = ___VARIABLE_sceneName___Router()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}