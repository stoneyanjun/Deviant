//
//  TopicListPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//
/*
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
        let deviationid = "001"
        let bases  = [DeviantDetailBase(deviationid: deviationid)]

        //When Then
        presenter.update(with: bases, nextOffset: offset)

        //Then
        XCTAssertEqual(viewController.nextOffset, offset)
        XCTAssertEqual(viewController.results.count, bases.count)
        XCTAssertEqual(viewController.results.first?.deviationid.wrap(), bases.first?.deviationid.wrap())
    }
    func testShowDeviation(with TopicResult: DeviantDetailBase) {
        //Given
        router.TopicResult = nil
        let deviationid = "001"
        let base = DeviantDetailBase(deviationid: deviationid)

        //When Then
        presenter.showDeviation(with: base)

        //Then
        XCTAssertNotNil(router.TopicResult)
        XCTAssertEqual(router.TopicResult?.deviationid.wrap(), deviationid)
    }
}

class TopicListViewControllerSpy: UIViewController, TopicListViewControllerInterface {
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

    func update(with results: [TopicListResult], nextOffset: Int) {
        
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
*/
