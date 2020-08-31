//
//  UIScreenModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

class UIScreenModel {
    let test: UITestableCase

    var app: XCUIApplication {
        return test.app
    }

    init(_ test: UITestableCase,
                file: StaticString = #file,
                line: Int = #line) {
        self.test = test
        test.waitForElementToExist(identifyingElement, file: file, line: line)
    }

    var identifyingElement: XCUIElement {
        return app.navigationBars.firstMatch
    }
}
