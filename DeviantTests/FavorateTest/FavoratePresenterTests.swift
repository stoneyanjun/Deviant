//
//  FavoratePresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class FavoratePresenterTests: XCTestCase {
    var presenter: FavoratePresenter!
    var viewController: FavorateViewControllerSpy!
    var router: FavorateRouterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        presenter = FavoratePresenter()
        viewController = FavorateViewControllerSpy()
        router = FavorateRouterSpy()

        presenter.viewController = viewController
        presenter.router = router
    }

    func testSetLoadingView() {
        //Given
        viewController.called = false

        //When
        presenter.setLoadingView(with: true)

        //Then
        XCTAssertTrue(viewController.called)
    }

    func testShowError() {
        //Given
        viewController.showErrorCalled = false

        //When
        presenter.showError(with: DeviantGeneralError.unknownError)

        //Then
        XCTAssertTrue(viewController.showErrorCalled)
    }

    func testUpdate() {
        //Given
        viewController.favorates.removeAll()
        let viewData = DeviantMockData.favorate.toDisplayModel()

        //When
        viewController.update(with: [viewData], nextOffset: offset)

        //Then
        XCTAssertEqual(viewController.favorates.count, 1)
    }
}

class FavorateViewControllerSpy: UIViewController, FavorateViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var favorates: [FavorateDisplayModel] = []
    var nextOffset = 0

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with favorates: [FavorateDisplayModel], nextOffset: Int) {
        self.favorates = favorates
        self.nextOffset = nextOffset
    }
}

class FavorateRouterSpy: FavorateRouterInterface {
}
