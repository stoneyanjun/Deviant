//
//  CommentTableViewCell.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

extension ScreenModel {
    /// Let the application wait for a while.
    ///
    /// - Parameter timeout: timeout value
    /// - Returns: the current ScreenModel object.
    @discardableResult
    func wait(for timeout: TimeInterval = Const.waitTime) -> Self {
        _ = app.wait(for: .runningBackground, timeout: timeout)
        return reportSelf()
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
    func swipeUp() -> Self {
        app.tables.firstMatch.swipeUp()
        return reportSelf()
    }

    @discardableResult
    func swipeDown() -> Self {
        app.tables.firstMatch.swipeDown()
        return self
    }
}
