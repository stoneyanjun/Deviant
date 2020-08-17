//
//  FavorateInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol FavorateInteractorInterface {
    func tryFetchFavorates()
}

protocol FavorateRouterInterface {
}

protocol FavoratePresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with favorate: WhoFavorateBase)
}

protocol FavorateViewControllerInterface: UIViewController {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with favorates: [FavorateTableViewCell.ViewData])
}
