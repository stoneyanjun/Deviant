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
    func showDeviation(with deviantDetail: DeviantDetailDisplay)
}

protocol TopicListRouterInterface {
    var navigationController: UINavigationController? { get set }

    func showTopic(with topicName: String)
    func showDeviation(with deviantDetail: DeviantDetailDisplay)
}

protocol TopicListPresenterInterface {
    func showDeviation(with deviantDetail: DeviantDetailDisplay)
    func showTopic(with topicName: String)
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with displayModels: [TopicListDisplay], nextOffset: Int)
}

protocol TopicListViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with displayModels: [TopicListDisplay], nextOffset: Int)
}
