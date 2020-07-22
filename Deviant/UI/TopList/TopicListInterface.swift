//
//  TopicListInterface.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

protocol TopicListInteractorInterface {
    func tryFetchTopicList(with offset: Int)
}

protocol TopicListRouterInterface {
}

protocol TopicListPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [TopicListResults], nextOffset: Int)
}

protocol TopicListViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with results: [TopicListResults], nextOffset: Int)
}