//
//  TopicDetailInterface.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

protocol TopicDetailInteractorInterface {
    func tryFetchTopic(with offset: Int)
}

protocol TopicDetailRouterInterface {
}

protocol TopicDetailPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [TopicDetailResult], nextOffset: Int)
}

protocol TopicDetailViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with results: [TopicDetailResult], nextOffset: Int)
}
