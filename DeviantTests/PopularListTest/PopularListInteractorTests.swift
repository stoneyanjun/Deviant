//
//  PopularListInteractorTests.swift
//  DeviantTests
//
//  Created by Stone on 14/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import XCTest

class PopularListInteractorTests: XCTestCase {
//    var interactor: PopularListInteractor!
//    var Presenter: PopularListPresenterSpy!

    override func setUp() {
        super.setUp()
    }
}

class PopularListPresenterSpy: PopularListPresenterInterface {
    var setLoadingViewCalled = false
    var showErrorCalled = false
    var updateCalled = false
    var showDeviationCalled = false

    func setLoadingView(with status: Bool) {
        setLoadingViewCalled = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with results: [DeviantDetailBase], nextOffset: Int) {
        updateCalled = true
    }

    func showDeviation(with popularResult: DeviantDetailBase) {
        showDeviationCalled = true
    }
}
