//
//  UIView+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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

extension UIView {
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}
