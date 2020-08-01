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
    func showTopic(with topicName: String) {
        if let navi = navigationController {
            let config = TopicDetailConfiguration(navigationController: navi, topicName: topicName)
            let topicDetailVC = TopicDetailConfigurator(config: config).createViewController()
            navi.pushViewController(topicDetailVC, animated: true)
        }
    }
}
