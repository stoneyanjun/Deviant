//
//  DailyListInterface.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

protocol DailyListInteractorInterface {
    func tryFetchDaily(with date: String)
    func showDeviation(with dailyResult: DeviantDetailBase)
}

protocol DailyListRouterInterface {
    func showDeviation(with dailyResult: DeviantDetailBase)
}

protocol DailyListPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [DeviantDetailBase])
    func showDeviation(with dailyResult: DeviantDetailBase)
}

protocol DailyListViewControllerInterface: UIViewController {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with results: [DeviantDetailBase])
}
