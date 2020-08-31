//
//  CommonListRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class CommonListRouter: NSObject {
    weak var navigationController: UINavigationController?
    weak var viewController: CommonListViewControllerInterface?
}

extension CommonListRouter: CommonListRouterInterface {
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        guard let navi = navigationController else { return }
        let detailParams = DeviantDetailParams(deviationid: deviantDetail.deviationid ,
                                               username: deviantDetail.username ,
                                               title: deviantDetail.title)
        let config = DeviantDetailConfiguration(navigationController: navi, detailParams: detailParams)
        let deviantDetailVC = DeviantDetailConfigurator(config: config).createViewController()
        navi.pushViewController(deviantDetailVC, animated: true)
    }
}
