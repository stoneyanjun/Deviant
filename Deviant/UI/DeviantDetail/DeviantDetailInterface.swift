//
//  DeviantDetailInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol DeviantDetailInteractorInterface {
    func tryFetchDeviantDetail()
}

protocol DeviantDetailRouterInterface {
}

protocol DeviantDetailPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with deviantDetail: DeviantDetailBase)
}

protocol DeviantDetailViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with deviantDetail: DeviantDetailBase)
}
