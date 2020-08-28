//
//  CommentPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class CommentPresenter {
    weak var viewController: CommentViewControllerInterface?
    var router: CommentRouterInterface?
}

extension CommentPresenter: CommentPresenterInterface {
    func setLoadingView(with status: Bool) {
        viewController?.setLoadingView(with: status)
    }

    func showError(with error: Error) {
        viewController?.showError(with: error)
    }

    func update(with comments: [CommentDisplayModel], nextOffset: Int) {
        viewController?.update(with: comments, nextOffset: nextOffset)
    }
}
