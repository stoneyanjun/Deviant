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
    func showDeviation(with dailyResult: DeviantDetailBase) {
        guard let navi = navigationController else { return }

        let detailParams = DeviantDetailParams(deviationid: dailyResult.deviationid.wrap() ,
                                               username: dailyResult.author?.username ,
                                               title: dailyResult.title ,
                                               favourites: dailyResult.stats?.favourites,
                                               comments: dailyResult.stats?.comments)
        let config = DeviantDetailConfiguration(navigationController: navi, detailParams: detailParams)
        let deviantDetailVC = DeviantDetailConfigurator(config: config).createViewController()
        navi.pushViewController(deviantDetailVC, animated: true)
    }
}
