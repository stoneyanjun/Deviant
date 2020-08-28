//
//  TopicDetailInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol TopicDetailInteractorInterface {
    func tryFetchTopic(with offset: Int)
    func showDeviation(with topicDetail: DeviantDetailDisplayModel)
}

protocol TopicDetailRouterInterface {
    func showDeviation(with topicDetail: DeviantDetailDisplayModel)
}

protocol TopicDetailPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [DeviantDetailDisplayModel], nextOffset: Int)
    func showDeviation(with topicDetail: DeviantDetailDisplayModel)
}

protocol TopicDetailViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with results: [DeviantDetailDisplayModel], nextOffset: Int)
}
