//
//  CommentInterface.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

protocol CommentInteractorInterface {
    func tryFetchComments()
}

protocol CommentRouterInterface {
}

protocol CommentPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with comment: CommentBase)
}

protocol CommentViewControllerInterface: UIViewController {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with comments: [CommentTableViewCell.ViewData])
}
