//
//  DailyListRouter.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class DailyListRouter: NSObject {
    weak var viewController: DailyListViewControllerInterface?
}

extension DailyListRouter: DailyListRouterInterface {
}