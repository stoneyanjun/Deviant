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
        viewController.update(with: [viewData])

        //Then
        XCTAssertEqual(viewController.favorates.count, 1)
    }
}

class FavorateViewControllerSpy: UIViewController, FavorateViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var favorates: [FavorateTableViewCell.ViewData] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with favorates: [FavorateTableViewCell.ViewData]) {
        self.favorates = favorates
    }
}

class FavorateRouterSpy: FavorateRouterInterface {
}
