//
//  CommentPresenter.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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
    
    func update(with comment: CommentBase) {
        guard let threads = comment.thread else {
            return
        }
        var comments: [CommentTableViewCell.ViewData] = []
        for thread in threads {
            comments.append(thread.toDisplayModel())
        }
        viewController?.update(with: comments)
    }
}
