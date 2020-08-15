//
//  TopicDetailInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol TopicDetailInteractorInterface {
    func tryFetchTopic(with offset: Int)
    func showDeviation(with topicDetail: DeviantDetailBase)
}

protocol TopicDetailRouterInterface {
    func showDeviation(with topicDetail: DeviantDetailBase)
}

protocol TopicDetailPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [DeviantDetailBase], nextOffset: Int)
    func showDeviation(with topicDetail: DeviantDetailBase)
}

protocol TopicDetailViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with results: [DeviantDetailBase], nextOffset: Int)
}
