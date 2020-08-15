//
//  PopularListRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class PopularListRouter: NSObject {
    var navigationController: UINavigationController?
    weak var viewController: PopularListViewControllerInterface?
}

extension PopularListRouter: PopularListRouterInterface {
    func showDeviation(with popularResult: DeviantDetailBase) {
        guard let navi = navigationController else { return }

        let detailParams = DeviantDetailParams(deviationid: popularResult.deviationid.wrap() ,
                                               username: popularResult.author?.username ,
                                               title: popularResult.title ,
                                               favourites: popularResult.stats?.favourites ,
                                               comments: popularResult.stats?.comments)
        let config = DeviantDetailConfiguration(navigationController: navi, detailParams: detailParams)
        let deviantDetailVC = DeviantDetailConfigurator(config: config).createViewController()
        navi.pushViewController(deviantDetailVC, animated: true)
    }
}
