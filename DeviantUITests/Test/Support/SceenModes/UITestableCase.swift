//
//  UITestableCase.swift
//  DeviantUITests
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
    var locale: Locale { get }
}
