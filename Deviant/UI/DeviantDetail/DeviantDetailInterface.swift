//
//  DeviantDetailInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol DeviantDetailInteractorInterface {
    func tryFetchDeviantDetail()
    func showMoreDetail(with deviantDetail: DeviantDetailDisplayModel, tag: Int)
}

protocol DeviantDetailRouterInterface {
    func showMoreDetail(with deviantDetail: DeviantDetailDisplayModel, tag: Int)
}

protocol DeviantDetailPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with deviantDetail: DeviantDetailDisplayModel)
    func showMoreDetail(with deviantDetail: DeviantDetailDisplayModel, tag: Int)
}

protocol DeviantDetailViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with deviantDetail: DeviantDetailDisplayModel)
}
