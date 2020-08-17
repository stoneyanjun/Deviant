//
//  PopularListPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class PopularListPresenterTests: XCTestCase {
    var presenter: PopularListPresenter!
    var viewController: PopularListViewControllerSpy!
    var router: PopularListRouterSpy!

    override func setUp() {
        super.setUp()
        presenter = PopularListPresenter()
        viewController = PopularListViewControllerSpy()
        router = PopularListRouterSpy()

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
        viewController.nextOffset = -1
        viewController.results.removeAll()

        //When
        let offset = 1
        presenter.update(with: [DeviantMockData.detail], nextOffset: offset)

        //Then
        XCTAssertEqual(viewController.nextOffset, offset)
        XCTAssertEqual(viewController.results.count, 1)
        XCTAssertEqual(viewController.results.first?.deviationid.wrap(), DeviantMockData.deviantId)
    }
    func testShowDeviation() {
        //Given
        router.popularResult = nil

        //When
        presenter.showDeviation(with: DeviantMockData.detail)

        //Then
        XCTAssertNotNil(router.popularResult)
        XCTAssertEqual(router.popularResult?.deviationid.wrap(), DeviantMockData.deviantId)
    }
}

class PopularListViewControllerSpy: UIViewController, PopularListViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var nextOffset = -1
    var results: [DeviantDetailBase] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with results: [DeviantDetailBase], nextOffset: Int) {
        self.nextOffset = nextOffset
        self.results.append(contentsOf: results)
    }
}

class PopularListRouterSpy: PopularListRouterInterface {
    var popularResult: DeviantDetailBase?

    func showDeviation(with popularResult: DeviantDetailBase) {
        self.popularResult = popularResult
    }
}