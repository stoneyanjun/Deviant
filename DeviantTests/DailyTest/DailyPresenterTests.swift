//
//  DailyListPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class DailyListPresenterTests: XCTestCase {
    var presenter: DailyListPresenter!
    var viewController: DailyListViewControllerSpy!
    var router: DailyListRouterSpy!

    override func setUp() {
        super.setUp()
        presenter = DailyListPresenter()
        viewController = DailyListViewControllerSpy()
        router = DailyListRouterSpy()

        presenter.viewController = viewController
        presenter.router = router
    }

    func testSetLoadingView() {
        //Given
        viewController.called = false

        //When Then
        presenter.setLoadingView(with: true)

        //Then
        XCTAssertTrue(viewController.called)
    }

    func testShowError() {
        //Given
        viewController.showErrorCalled = false

        //When Then
        presenter.showError(with: DeviantGeneralError.unknownError)

        //Then
        XCTAssertTrue(viewController.showErrorCalled)
    }

    func testUpdate() {
        //Given
        viewController.results.removeAll()

        //When
        presenter.update(with: [DeviantMockData.detail])

        //Then
        XCTAssertEqual(viewController.results.count, 1)
        XCTAssertEqual(viewController.results.first?.deviationid.wrap(),
                       DeviantMockData.deviantId)
    }

    func testShowDeviation() {
        //Given
        router.deviation = nil

        //When
        presenter.showDeviation(with: DeviantMockData.detail)

        //Then
        XCTAssertEqual(router.deviation?.deviationid.wrap(),
                       DeviantMockData.deviantId)
    }
}

class DailyListViewControllerSpy: UIViewController, DailyListViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var results: [DeviantDetailBase] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with results: [DeviantDetailBase]) {
        self.results.append(contentsOf: results)
    }
}

class DailyListRouterSpy: DailyListRouterInterface {
    var deviation: DeviantDetailBase?
    var navigationController: UINavigationController?

    func showDeviation(with dailyResult: DeviantDetailBase) {
        self.deviation = dailyResult
    }
}
