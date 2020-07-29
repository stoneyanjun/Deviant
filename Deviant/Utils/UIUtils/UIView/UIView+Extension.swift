//
//  UIView+Extension.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    static var className: String {
        return String(describing: self)
    }
}

extension UIView {
    static func createNib() -> UINib {
        return UINib(nibName: className, bundle: Bundle.main)
    }
}
