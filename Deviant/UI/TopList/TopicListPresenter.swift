//
//  TopicListPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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

    func update(with displayModels: [TopicListDisplay], nextOffset: Int) {
        viewController?.update(with: displayModels, nextOffset: nextOffset)
    }

    func showTopic(with topicName: String) {
        self.router?.showTopic(with: topicName)
    }

    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        self.router?.showDeviation(with: deviantDetail)
    }
}
