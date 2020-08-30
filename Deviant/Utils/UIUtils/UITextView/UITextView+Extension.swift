//
//  UILabel+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

extension UITextView {
    static func make(with text: String? = nil,
                     color: UIColor? = nil,
                     font: UIFont? = nil,
                     alignment: NSTextAlignment? = .left) -> UITextView {
        let textView = UITextView()
        textView.adjustsFontForContentSizeCategory = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.defaultBackground

        textView.text = text.wrap()
        if let textColor = color {
            textView.textColor = textColor
        }
        if let textFont = font {
            textView.font = textFont
        }
        if let textAlignment = alignment {
            textView.textAlignment = textAlignment
        }

        return textView
    }
}
