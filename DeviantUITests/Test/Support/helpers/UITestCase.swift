//
//  CommentTableViewCell.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import FBSnapshotTestCase
import UIKit
import XCTest

typealias UITestableCase = UITestable & XCTestCase

protocol UITestable {
    var app: XCUIApplication { get }
}

class UITestCase: FBSnapshotTestCase, UITestable {
    var app: XCUIApplication {
        return _app
    }

    private(set) var _app: XCUIApplication!

    func launchApp(isRecordModel: Bool = false) {
        recordMode = isRecordModel
        continueAfterFailure = true
        let application = XCUIApplication()
        application.launchArguments.append("deviantUITests")
        application.launch()
        _app = application
    }
}

extension XCTestCase {
    static let waitSeconds: TimeInterval = 30.0

    func waitForElementToExist(_ element: XCUIElement,
                               waitSeconds: TimeInterval = waitSeconds,
                               file: StaticString = #file,
                               line: Int = #line) {
        evaluateAssertion("exists == true",
                          element: element,
                          waitSeconds: waitSeconds,
                          file: file,
                          line: line)
    }

    private func evaluateAssertion(_ predicateFormat: String,
                                   element: XCUIElement,
                                   waitSeconds: TimeInterval = waitSeconds,
                                   file: StaticString = #file,
                                   line: Int = #line) {
        let predicate = NSPredicate(format: predicateFormat)
        let xpectation = expectation(for: predicate,
                                     evaluatedWith: element,
                                     handler: nil)
        let result = XCTWaiter().wait(for: [xpectation], timeout: waitSeconds)

        guard result == .completed else {
            let message = "Fail to find the element after waiting"
            recordFailure(withDescription: message,
                          inFile: file.description,
                          atLine: Int(line),
                          expected: true)
            return
        }
        XCTAssert(true, "Element found")
    }
}
