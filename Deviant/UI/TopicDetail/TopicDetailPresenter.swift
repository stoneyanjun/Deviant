//
//  TopicDetailPresenter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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

    func update(with results: [TopicDetailResult], nextOffset: Int) {
        viewController?.update(with: results, nextOffset: nextOffset)
    }
    func showDeviation(with topicDetail: TopicDetailResult) {
        router?.showDeviation(with: topicDetail)
    }
}
