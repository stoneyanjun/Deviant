//
//  UIViewController+Extension.swift
//  Deviant
//
//  Created by stone on 2020/7/4.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return String(describing: type(of: self))
    }
}

extension UIViewController {
    static func instance() -> Self {
        return createFromXib()
    }

    static func createFromXib<T: UIViewController> () -> T {
        return T(nibName: className, bundle: nil)
    }
}
