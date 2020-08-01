//
//  PopularListRouter.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

class PopularListRouter: NSObject {
    var navigationController: UINavigationController?
    weak var viewController: PopularListViewControllerInterface?
}

extension PopularListRouter: PopularListRouterInterface {
    func showDeviation(with popularResult: PopularResult) {
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
