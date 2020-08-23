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

    class func headlineFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .headline)
    }

    class func subheadlineFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .subheadline)
    }

    class func bodyFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .body)
    }

    class func footnoteFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: .footnote)
    }
}
