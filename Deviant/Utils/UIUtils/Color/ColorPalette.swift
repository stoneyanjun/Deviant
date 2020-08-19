//
//  ColorPalette.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

struct ColorPalette {
    static let white = UIColor(red: 255, green: 255, blue: 255) ?? UIColor.white
    static let black = UIColor(red: 3, green: 3, blue: 3) ?? UIColor.black
    static let coral = UIColor(red: 244, green: 111, blue: 96) ?? UIColor.lightGray
    static let whiteSmoke = UIColor(red: 245, green: 245, blue: 245) ?? UIColor.white
    static let grayChateau = UIColor(red: 163, green: 164, blue: 168) ?? UIColor.gray
    static let defaultBackground = UIColor(red: 6, green: 7, blue: 12) ?? UIColor.black
}

extension UIColor {
    static var defaultBackground = UIColor(red: 6, green: 7, blue: 12)

    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
