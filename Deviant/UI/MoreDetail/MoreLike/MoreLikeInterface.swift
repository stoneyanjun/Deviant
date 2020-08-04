//
//  MoreLikeInterface.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

protocol MoreLikeInteractorInterface {
    func tryFetchMoreLike()
}

protocol MoreLikeRouterInterface {
}

protocol MoreLikePresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func updateMoreLikeThis(with results: [DeviantDetailBase])
    func updateUserStatus(with results: [UserStatusResults])
}

protocol MoreLikeViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func updateMoreLikeThis(with results: [DeviantDetailBase])
    func updateUserStatus(with results: [UserStatusResults])
}
