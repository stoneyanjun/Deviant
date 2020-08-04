//
//  CommentRouter.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class CommentRouter: NSObject {
    weak var viewController: CommentViewControllerInterface?
    var navigationController: UINavigationController?
}

extension CommentRouter: CommentRouterInterface {
}
