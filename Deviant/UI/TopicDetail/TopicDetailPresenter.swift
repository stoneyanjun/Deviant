//
//  TopicDetailPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class TopicDetailPresenter {
    weak var viewController: TopicDetailViewControllerInterface?
    var router: TopicDetailRouterInterface?
}

extension TopicDetailPresenter: TopicDetailPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with results: [DeviantDetailDisplayModel], nextOffset: Int) {
        viewController?.update(with: results, nextOffset: nextOffset)
    }

    func showDeviation(with topicDetail: DeviantDetailDisplayModel) {
        router?.showDeviation(with: topicDetail)
    }
}
