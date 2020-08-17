//
//  FavorateRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class FavorateRouter: NSObject {
    weak var viewController: FavorateViewControllerInterface?
    var navigationController: UINavigationController?
}

extension FavorateRouter: FavorateRouterInterface {
}
