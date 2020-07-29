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
}

protocol DailyListRouterInterface {
}

protocol DailyListPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
}

protocol DailyListViewControllerInterface: UIViewController {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
}
