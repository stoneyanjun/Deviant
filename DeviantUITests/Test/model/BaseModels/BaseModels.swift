//
//  BaseModels.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

class BaseScreenModel: ScreenModel {
    override var identifyingElement: XCUIElement {
        return app.navigationBars.firstMatch
    }
}
