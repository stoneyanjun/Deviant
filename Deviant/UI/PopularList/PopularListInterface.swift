//
//  PopularListInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol PopularListInteractorInterface {
    func tryFetchPopular(with offset: Int)
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol PopularListRouterInterface {
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol PopularListPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with displayModels: [DeviantDetailDisplayModel], nextOffset: Int)
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol PopularListViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with displayModels: [DeviantDetailDisplayModel], nextOffset: Int)
}
