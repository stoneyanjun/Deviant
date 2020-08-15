//
//  TopicListPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class TopicListPresenterTests: XCTestCase {
    var presenter: TopicListPresenter!
    var viewController: TopicListViewControllerSpy!
    var router: TopicListRouterSpy!

    override func setUp() {
        super.setUp()
        presenter = TopicListPresenter()
        viewController = TopicListViewControllerSpy()
        router = TopicListRouterSpy()

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
        viewController.nextOffset = -1
        viewController.results.removeAll()
        let offset = 1

        //When Then
        presenter.update(with: [DeviantMockData.topicListResult], nextOffset: offset)

        //Then
        XCTAssertEqual(viewController.nextOffset, offset)
        XCTAssertEqual(viewController.results.count, 1)
        XCTAssertEqual(viewController.results.first?.exampleDeviations?.first?.deviationid.wrap(),
                       DeviantMockData.topicListResult.exampleDeviations?.first?.deviationid.wrap())
    }

    func testShowDeviation() {
        //Given
        router.deviation = nil

        //When Then
        presenter.showDeviation(with: DeviantMockData.detail)

        //Then
        XCTAssertEqual(router.deviation?.deviationid.wrap(), DeviantMockData.deviantId)
    }

    func testShowTopic() {
        //Given
        router.topicName = ""

        //When
        presenter.showTopic(with: DeviantMockData.topicName)

        //Then
        XCTAssertEqual(router.topicName, DeviantMockData.topicName)
    }
}

class TopicListViewControllerSpy: UIViewController, TopicListViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var nextOffset = -1
    var results: [TopicListResult] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with results: [TopicListResult], nextOffset: Int) {
        self.results.append(contentsOf: results)
        self.nextOffset = nextOffset
    }
}

class TopicListRouterSpy: TopicListRouterInterface {
    var topicName = ""
    var deviation: DeviantDetailBase?
    var navigationController: UINavigationController?

    func showTopic(with topicName: String) {
        self.topicName = topicName
    }

    func showDeviation(with deviation: DeviantDetailBase) {
        self.deviation = deviation
    }
}

