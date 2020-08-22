//
//  DeviantDetailPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class DeviantDetailPresenterTests: XCTestCase {
    var presenter: DeviantDetailPresenter!
    var viewController: DeviantDetailViewControllerSpy!
    var router: DeviantDetailRouterSpy!

    override func setUp() {
        super.setUp()
        presenter = DeviantDetailPresenter()
        viewController = DeviantDetailViewControllerSpy()
        router = DeviantDetailRouterSpy()

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
        viewController.deviantDetail = nil

        //When
        presenter.update(with: DeviantMockData.detail)

        //Then
        XCTAssertEqual(viewController.deviantDetail?.deviationid.wrap(),
                       DeviantMockData.deviantId)
    }
    func testShowMoreDetail() {
        //Given
        let tag = 0
        router.showMoreDetailCalled = false

        //When
        presenter.showMoreDetail(with: DeviantMockData.detail, tag: tag)

        //Then
        XCTAssertTrue(viewController.showMoreDetailCalled)
    }
}

class DeviantDetailViewControllerSpy: UIViewController, DeviantDetailViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var deviantDetail: DeviantDetailBase?

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with deviantDetail: DeviantDetailBase) {
        self.deviantDetail = deviantDetail
    }
}

class DeviantDetailRouterSpy: DeviantDetailRouterInterface {
    var showMoreDetailCalled = false

    func showMoreDetail(with deviantDetail: DeviantDetailBase, tag: Int) {
        showMoreDetailCalled = true
    }
}
