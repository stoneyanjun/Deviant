//
//  TopicDetailPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class TopicDetailPresenterTests: XCTestCase {
    var presenter: TopicDetailPresenter!
    var viewController: TopicDetailViewControllerSpy!
    var router: TopicDetailRouterSpy!
    var offset = 1

    override func setUp() {
        super.setUp()
        presenter = TopicDetailPresenter()
        viewController = TopicDetailViewControllerSpy()
        router = TopicDetailRouterSpy()

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
        offset = 1
        viewController.nextOffset = -1
        viewController.results.removeAll()

        //When
        presenter.update(with: [DeviantMockData.detail.toDisplayModel()], nextOffset: offset)

        //Then
        XCTAssertEqual(viewController.nextOffset, offset)
        XCTAssertEqual(viewController.results.first?.deviationid,
                       DeviantMockData.deviantId)
    }

    func testShowDeviation() {
        //Given
        router.topicDetail = nil

        //When
        presenter.showDeviation(with: DeviantMockData.detail.toDisplayModel())

        //Then
        XCTAssertEqual(router.topicDetail?.deviationid,
                       DeviantMockData.deviantId)
    }
}

class TopicDetailViewControllerSpy: UIViewController, TopicDetailViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var results: [DeviantDetailDisplayModel] = []
    var nextOffset = 0

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with results: [DeviantDetailDisplayModel], nextOffset: Int) {
        self.results.append(contentsOf: results)
        self.nextOffset = nextOffset
    }
}

class TopicDetailRouterSpy: TopicDetailRouterInterface {
    var topicDetail: DeviantDetailDisplayModel?
    var navigationController: UINavigationController?

    func showDeviation(with topicDetail: DeviantDetailDisplayModel) {
        self.topicDetail = topicDetail
    }
}
