//
//  TopicListRouter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class TopicListRouter: NSObject {
    weak var viewController: TopicListViewControllerInterface?
}

extension TopicListRouter: TopicListRouterInterface {
    func showTopic(with topicName: String) {
    }
}
