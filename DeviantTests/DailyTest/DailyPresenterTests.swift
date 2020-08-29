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
        viewController.results.removeAll()

        //When
        presenter.update(with: [DeviantMockData.detail.toDisplayModel()])

        //Then
        XCTAssertEqual(viewController.results.count, 1)
        XCTAssertEqual(viewController.results.first?.deviationid,
                       DeviantMockData.deviantId)
    }

    func testShowDeviation() {
        //Given
        router.deviation = nil

        //When
        presenter.showDeviation(with: DeviantMockData.detail.toDisplayModel())

        //Then
        XCTAssertEqual(router.deviation?.deviationid,
                       DeviantMockData.deviantId)
    }
}

class DailyListViewControllerSpy: UIViewController, DailyListViewControllerInterface {
    func update(with results: [DeviantDetailDisplayModel]) {
        self.results.append(contentsOf: results)
    }

    var called = false
    var showErrorCalled = false
    var results: [DeviantDetailDisplayModel] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }
}

class DailyListRouterSpy: DailyListRouterInterface {
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        self.deviation = deviantDetail
    }

    var deviation: DeviantDetailDisplayModel?
    var navigationController: UINavigationController?
}
