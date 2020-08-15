//
//  MoreLikeRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class MoreLikeRouter: NSObject {
    var navigationController: UINavigationController?
    weak var viewController: MoreLikeViewControllerInterface?
}

extension MoreLikeRouter: MoreLikeRouterInterface {
}
