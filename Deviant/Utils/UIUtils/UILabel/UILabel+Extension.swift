//
//  UILabel+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

extension UILabel {
    static func make(with title: String? = nil,
                     color: UIColor? = nil,
                     font: UIFont? = nil,
                     numOfLines: Int? = nil,
                     alignment: NSTextAlignment? = .left) -> UILabel {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = title.wrap()
        if let textColor = color {
            label.textColor = textColor
        }
        if let textFont = font {
            label.font = textFont
        }
        if let numberOfLines = numOfLines {
            label.numberOfLines = numberOfLines
        }
        if let textAlignment = alignment {
            label.textAlignment = textAlignment
        }

        return label
    }
}
