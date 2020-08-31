//
//  ScreenModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

open class ScreenModel {
    public let test: UITestableCase

    public var app: XCUIApplication {
        return test.app
    }

    public init(_ test: UITestableCase,
                file: StaticString = #file,
                function: StaticString = #function,
                line: Int = #line) {
        self.test = test
        waitForViewToAppear(file: file, function: function, line: line)
    }

    open var identifyingElement: XCUIElement {
        fatalError("This has to be implemented in a subcall or extension")
    }

    public func reportSelf(_ function: StaticString = #function) -> Self {
        test.report(function: function.description)
        return self
    }

    @discardableResult func waitForViewToAppear(file: StaticString,
                                                function: StaticString,
                                                line: Int) -> Self {
        test.waitForElementToExist(identifyingElement, file: file, line: line)
        return self
    }
}
