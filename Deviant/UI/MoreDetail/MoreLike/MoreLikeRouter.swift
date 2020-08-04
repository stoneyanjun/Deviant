//
//  MoreLikeRouter.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class MoreLikeRouter: NSObject {
    var navigationController: UINavigationController?
    weak var viewController: MoreLikeViewControllerInterface?
}

extension MoreLikeRouter: MoreLikeRouterInterface {
}
