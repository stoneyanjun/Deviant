//
//  TopicDetailRouter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class TopicDetailRouter: NSObject {
    var navigationController: UINavigationController?
    weak var viewController: TopicDetailViewControllerInterface?
}

extension TopicDetailRouter: TopicDetailRouterInterface {
    func showDeviation(with topicDetail: DeviantDetailBase) {
        guard let navi = navigationController else { return }

        let detailParams = DeviantDetailParams(deviationid: topicDetail.deviationid.wrap() ,
                                               username: topicDetail.author?.username ,
                                               title: topicDetail.title ,
                                               favourites: topicDetail.stats?.favourites,
                                               comments: topicDetail.stats?.comments)
        let config = DeviantDetailConfiguration(navigationController: navi, detailParams: detailParams)
        let deviantDetailVC = DeviantDetailConfigurator(config: config).createViewController()
        navi.pushViewController(deviantDetailVC, animated: true)
    }
}
