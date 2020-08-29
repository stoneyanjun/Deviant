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
        let offset = 1

        //When
        presenter.update(with: [DeviantMockData.topicListResult.toDisplayModel() ], nextOffset: offset)

        //Then
        XCTAssertEqual(viewController.nextOffset, offset)
        XCTAssertEqual(viewController.results.count, 1)
        XCTAssertEqual(viewController.results.first?.deviantDetails?.first?.deviationid ,
                       DeviantMockData.topicListResult.deviations?.first?.deviationid )
    }

    func testShowDeviation() {
        //Given
        router.deviation = nil

        //When
        presenter.showDeviation(with: DeviantMockData.detail.toDisplayModel())

        //Then
        XCTAssertEqual(router.deviation?.deviationid, DeviantMockData.deviantId)
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
    var results: [TopicListDisplay] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with results: [TopicListDisplay], nextOffset: Int) {
        self.results.append(contentsOf: results)
        self.nextOffset = nextOffset
    }
}

class TopicListRouterSpy: TopicListRouterInterface {
    var topicName = ""
    var deviation: DeviantDetailDisplayModel?
    var navigationController: UINavigationController?

    func showTopic(with topicName: String) {
        self.topicName = topicName
    }

    func showDeviation(with deviation: DeviantDetailDisplayModel) {
        self.deviation = deviation
    }
}
