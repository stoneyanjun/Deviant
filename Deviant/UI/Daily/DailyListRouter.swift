//
//  DailyListRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class DailyListRouter: NSObject {
    weak var viewController: DailyListViewControllerInterface?
    var navigationController: UINavigationController?
}

extension DailyListRouter: DailyListRouterInterface {
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
