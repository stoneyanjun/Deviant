//
//  DailyListInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol DailyListInteractorInterface {
    func tryFetchDaily(with date: String)
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol DailyListRouterInterface {
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol DailyListPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [DeviantDetailDisplayModel])
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel)
}

protocol DailyListViewControllerInterface: UIViewController {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [DeviantDetailDisplayModel])
}
