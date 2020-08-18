//
//  UIFont+ExampleFonts.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

extension UIFont {
    class func exampleAvenirMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Book", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func exampleAvenirLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

enum DevinatFont: String {
    case systemFont = "System Font"

    func font(size: FontSize) -> UIFont {
        return dynamicFont(size: size, weight: UIFont.Weight.regular)
    }

    func boldFont(size: FontSize) -> UIFont {
        return dynamicFont(size: size, weight: UIFont.Weight.bold)
    }

    func semiBold(size: FontSize) -> UIFont {
        return dynamicFont(size: size, weight: UIFont.Weight.semibold)
    }

    func lightFont(size: FontSize) -> UIFont {
        return dynamicFont(size: size, weight: UIFont.Weight.light)
    }

    func mediumFont(size: FontSize) -> UIFont {
        return dynamicFont(size: size, weight: UIFont.Weight.medium)
    }

    private func dynamicFont(size: FontSize, weight: UIFont.Weight) -> UIFont {
        var scale = UIApplication.shared.fontScaleFactor()
        scale = (scale < 0.1) ? 1.0 : scale
        return UIFont.systemFont(ofSize: scale * size.rawValue, weight: weight)
    }
}

enum FontSize: CGFloat {
    case display = 34.0
    case headline = 28.0
    case title = 24.0
    case medium = 25.0
    case titleTwo = 20.0
    case body = 16.0
    case caption = 14.0
    case captionTwo = 11.0
    case footnote = 12.0
    case littleFootnote = 10.0
}
