//
//  CommentTableViewCell.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import FBSnapshotTestCase
import UIKit
import XCTest

class UITestCase: FBSnapshotTestCase, UITestable {
    var app: XCUIApplication {
        return _app
    }

    private(set) var _app: XCUIApplication!

    func launchApp(isRecordModel: Bool = false) {
        // If in recordMode, the test should continue to save all images in the test, otherwise we should stop test to save CI time.
        recordMode = isRecordModel
        continueAfterFailure = recordMode

        let application = XCUIApplication()

        application.launchArguments.append("deviantUITests")
        application.launch()

        _app = application
    }
}

// Solution found in https://stackoverflow.com/questions/32821880/ui-test-deleting-text-in-text-field
// Fix for the cursor issue, cursor always at the beginning of value see: https://stackoverflow.com/a/50310444
extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        let lowerRightCorner = coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
        lowerRightCorner.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
        typeText(text)
    }
}
