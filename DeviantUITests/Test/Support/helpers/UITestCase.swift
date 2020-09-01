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
        application.launchArguments.append("deviantUITestMode")
        application.launch()
        _app = application
    }
}

extension XCTestCase {
    static let waitTime: TimeInterval = 20.0

    func waitForElementToExist(_ element: XCUIElement,
                               waitTime: TimeInterval = waitTime,
                               file: StaticString = #file,
                               line: Int = #line) {
        evaluate("exists == true",
                          element: element,
                          waitTime: waitTime,
                          file: file,
                          line: line)
    }

    private func evaluate(_ predicateFormat: String,
                                   element: XCUIElement,
                                   waitTime: TimeInterval = waitTime,
                                   file: StaticString = #file,
                                   line: Int = #line) {
        let predicate = NSPredicate(format: predicateFormat)
        let currentEpectation = expectation(for: predicate,
                                     evaluatedWith: element,
                                     handler: nil)
        let result = XCTWaiter().wait(for: [currentEpectation], timeout: waitTime)

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
