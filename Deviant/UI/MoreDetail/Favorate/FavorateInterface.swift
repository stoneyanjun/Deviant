//
//  FavorateInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol FavorateInteractorInterface {
    func tryFetchFavorates(offset: Int)
}

protocol FavorateRouterInterface {
}

protocol FavoratePresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with favorates: [FavorateDisplayModel], nextOffset: Int)
}

protocol FavorateViewControllerInterface: UIViewController {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with favorates: [FavorateDisplayModel], nextOffset: Int)
}
