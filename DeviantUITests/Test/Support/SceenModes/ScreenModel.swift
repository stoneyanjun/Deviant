//
//  ScreenModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

class ScreenModel {
    let test: UITestableCase

    var app: XCUIApplication {
        return test.app
    }

    init(_ test: UITestableCase,
                file: StaticString = #file,
                function: StaticString = #function,
                line: Int = #line) {
        self.test = test
        waitForViewToAppear(file: file, function: function, line: line)
    }

    var identifyingElement: XCUIElement {
        fatalError("Subclasses or extension must override.")
    }

    @discardableResult func waitForViewToAppear(file: StaticString,
                                                function: StaticString,
                                                line: Int) -> Self {
        test.waitForElementToExist(identifyingElement, file: file, line: line)
        return self
    }
}
