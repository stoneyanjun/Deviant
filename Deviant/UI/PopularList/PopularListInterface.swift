//
//  PopularListInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol PopularListInteractorInterface {
    func tryFetchPopular(with offset: Int)
    func showDeviation(with popularResult: DeviantDetailBase)
}

protocol PopularListRouterInterface {
    func showDeviation(with popularResult: DeviantDetailBase)
}

protocol PopularListPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [DeviantDetailBase], nextOffset: Int)
    func showDeviation(with popularResult: DeviantDetailBase)
}

protocol PopularListViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with results: [DeviantDetailBase], nextOffset: Int)
}
