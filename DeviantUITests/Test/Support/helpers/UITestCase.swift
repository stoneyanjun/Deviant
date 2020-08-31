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
        recordMode = isRecordModel
        continueAfterFailure = true
        let application = XCUIApplication()
        application.launchArguments.append("deviantUITests")
        application.launch()
        _app = application
    }
}
