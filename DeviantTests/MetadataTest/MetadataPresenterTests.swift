//
//  MetadataPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class MetadataPresenterTests: XCTestCase {
    var presenter: MetadataPresenter!
    var viewController: MetadataViewControllerSpy!
    var router: MetadataRouterSpy!

    override func setUp() {
        super.setUp()
        presenter = MetadataPresenter()
        viewController = MetadataViewControllerSpy()
        router = MetadataRouterSpy()

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
        viewController.meta = nil

        //When
        viewController.update(with: DeviantMockData.metadataBase)

        //Then
        XCTAssertEqual(viewController.meta?.metadata?.first?.deviationid.wrap(),
                       DeviantMockData.metadataBase.metadata?.first?.deviationid.wrap())
    }
}

class MetadataViewControllerSpy: UIViewController, MetadataViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var meta: MetadataBase?

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with meta: MetadataBase) {
        self.meta = meta
    }
}

class MetadataRouterSpy: MetadataRouterInterface {
}
