//
//  UILabel+Extension.swift
//  Deviant
//
//  Created by Stone on 18/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

extension UILabel {
    static func make(with title: String? = nil,
                     color: UIColor? = nil,
                     backgroundColor: UIColor? = nil,
                     font: UIFont? = nil,
                     numOfLines: Int? = 0,
                     alignment: NSTextAlignment? = .left) -> UILabel {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = title.wrap()
        if let textColor = color {
            label.textColor = textColor
        }
        if let bkColor = backgroundColor {
            label.backgroundColor = bkColor
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
