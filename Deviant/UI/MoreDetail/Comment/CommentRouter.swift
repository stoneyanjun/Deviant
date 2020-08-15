//
//  CommentRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class CommentRouter: NSObject {
    weak var viewController: CommentViewControllerInterface?
    var navigationController: UINavigationController?
}

extension CommentRouter: CommentRouterInterface {
}
