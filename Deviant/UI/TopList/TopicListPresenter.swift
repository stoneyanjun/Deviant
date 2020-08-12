//
//  TopicListPresenter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class TopicListPresenter {
    weak var viewController: TopicListViewControllerInterface?
    var router: TopicListRouterInterface?
}

extension TopicListPresenter: TopicListPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with results: [TopicListResult], nextOffset: Int) {
        viewController?.update(with: results, nextOffset: nextOffset)
    }

    func showTopic(with topicName: String) {
        self.router?.showTopic(with: topicName)
    }

    func showDeviation(with deviation: DeviantDetailBase) {
        self.router?.showDeviation(with: deviation)
    }
}
