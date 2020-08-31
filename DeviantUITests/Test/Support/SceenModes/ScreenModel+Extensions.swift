//
//  CommentTableViewCell.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import FBSnapshotTestCase
import Foundation
import XCTest

extension ScreenModel {
    @discardableResult
    func wait(for timeout: TimeInterval = Const.waitTime) -> Self {
        _ = app.wait(for: .runningBackground, timeout: timeout)
        return self
    }

    func to<T>(_ model: T) -> T {
        return model
    }

    @discardableResult
    func cell(at index: Int) -> XCUIElement? {
        return app.cells.element(boundBy: index)
    }

    @discardableResult
    func goBack() -> Self {
        app.navigationBars.firstMatch.buttons.firstMatch.tap()
        return self
    }

    @discardableResult
    func dismissPanModalViewController() -> Self {
        app.swipeDown()
        return self
    }
}

extension ScreenModel: SnapshotModel {
    var snapshotTestCase: FBSnapshotTestCase {
        guard let snapshotTestable = test as? FBSnapshotTestCase else {
            fatalError("Not SnapshotTestCase")
        }
        return snapshotTestable
    }
}
