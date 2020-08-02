//
//  DailyListRouter.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class DailyListRouter: NSObject {
    weak var viewController: DailyListViewControllerInterface?
    var navigationController: UINavigationController?
}

extension DailyListRouter: DailyListRouterInterface {
    func showDeviation(with dailyResult: DailyResult) {
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
