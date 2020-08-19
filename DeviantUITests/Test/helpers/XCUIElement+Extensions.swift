//
//  CommentTableViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import XCTest

extension XCUIElement {
    /**
     Typing `return` is equivalent of pressing "done" button on keyboard
     but it's more reliable during UI tests
     */
    func dismissKeyboard() {
        typeText(XCUIKeyboardKey.return.rawValue)
    }
    
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
