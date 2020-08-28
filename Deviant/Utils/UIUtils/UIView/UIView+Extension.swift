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

extension UIView {
    static func makeNormalStackView(_ axis: NSLayoutConstraint.Axis,
                                    space: CGFloat = 0.0) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = space
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
