//
//  UIScreen+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

public typealias UITestableCase = UITestable & XCTestCase

public protocol UITestable {
    var app: XCUIApplication { get }
}

public protocol Localizable {
    var local: Locale { get }
}

extension UITestable {
//    public func makeLaunchArguments(localizable: Localizable,
//                                    userInterfaceStyle: UIUserInterfaceStyle) -> [String] {
//        
//    }
}
