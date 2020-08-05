//
//  TopicListRouter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class TopicListRouter: NSObject {
    var navigationController: UINavigationController?
    weak var viewController: TopicListViewControllerInterface?
}

extension TopicListRouter: TopicListRouterInterface {
    func showDeviation(with deviation: DeviantDetailBase) {
        guard let navi = navigationController else { return }
        let detailParams = DeviantDetailParams(deviationid: deviation.deviationid.wrap(),
                                               username: deviation.author?.username,
                                               title: deviation.title,
                                               favourites: deviation.stats?.favourites,
                                               comments: deviation.stats?.comments)
        let config = DeviantDetailConfiguration(navigationController: navi, detailParams: detailParams)
        let deviantDetailVC = DeviantDetailConfigurator(config: config).createViewController()
        navi.pushViewController(deviantDetailVC, animated: true)
    }

    func showTopic(with topicName: String) {
        guard let navi = navigationController else { return }
        let config = TopicDetailConfiguration(navigationController: navi, topicName: topicName)
        let topicDetailVC = TopicDetailConfigurator(config: config).createViewController()
        navi.pushViewController(topicDetailVC, animated: true)
    }
}
