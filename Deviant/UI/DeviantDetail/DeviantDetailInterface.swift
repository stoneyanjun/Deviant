//
//  DeviantDetailInterface.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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
