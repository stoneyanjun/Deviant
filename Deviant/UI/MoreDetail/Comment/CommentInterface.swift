//
//  CommentInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol CommentInteractorInterface {
    func tryFetchComments(offset: Int)
}

protocol CommentRouterInterface {
}

protocol CommentPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with comments: [CommentDisplayModel], nextOffset: Int)
}

protocol CommentViewControllerInterface: UIViewController {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with comments: [CommentDisplayModel], nextOffset: Int)
}
