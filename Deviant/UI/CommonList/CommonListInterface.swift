//
//  CommonListInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol CommonListInteractorInterface {
    func tryFetchList(with offset: Int)
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol CommonListRouterInterface {
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol CommonListPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with displayModels: [DeviantDetailDisplayModel], nextOffset: Int)
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol CommonListViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with displayModels: [DeviantDetailDisplayModel], nextOffset: Int)
}
