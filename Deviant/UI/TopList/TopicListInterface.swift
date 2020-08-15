//
//  TopicListInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol TopicListInteractorInterface {
    func tryFetchTopicList(with offset: Int)
    func showTopic(with topicName: String)
    func showDeviation(with deviation: DeviantDetailBase)
}

protocol TopicListRouterInterface {
    var navigationController: UINavigationController? { get set }
    func showTopic(with topicName: String)
    func showDeviation(with deviation: DeviantDetailBase)
}

protocol TopicListPresenterInterface {
    func showDeviation(with deviation: DeviantDetailBase)
    func showTopic(with topicName: String)
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [TopicListResult], nextOffset: Int)
}

protocol TopicListViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with results: [TopicListResult], nextOffset: Int)
}
