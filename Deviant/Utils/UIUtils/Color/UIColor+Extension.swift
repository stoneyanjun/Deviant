//
//  UIColor+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

extension UIColor {
    static let defaultBackground = UIColor(red: 6, green: 7, blue: 12)
    static let tagCellBackground = UIColor(red: 35, green: 39, blue: 43)
    static let coral = UIColor(red: 244, green: 111, blue: 96) ?? .red
    static let whiteSmoke = UIColor(red: 245, green: 245, blue: 245) ?? .white
    static let grayChateau = UIColor(red: 163, green: 164, blue: 168) ?? .lightGray

    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
