//
//  TopicListInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class TopicListInteractorTests: XCTestCase {
    var interactor: TopicListInteractor!
    var presenter: TopicListPresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = TopicListConfiguration()
        interactor = TopicListInteractor(config: configuration)
        presenter = TopicListPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchTopicList() {
        //Given
        offset = 0
        presenter.called = false

        //When
        interactor.tryFetchTopicList(with: offset)

        //Then
        XCTAssertTrue(presenter.called)
    }

    func testShowTopic() {
        //Given
        presenter.topicName = ""

        //When
        interactor.showTopic(with: DeviantMockData.topicName)

        //Then
        XCTAssertEqual(presenter.topicName, DeviantMockData.topicName)
    }

    func testShowDeviation() {
        //Given
        presenter.deviation = nil

        //When
        interactor.showDeviation(with: DeviantMockData.detail)

        //Then
        XCTAssertEqual(presenter.deviation?.deviationid.wrap(), DeviantMockData.deviantId)
    }
}

class TopicListPresenterSpy: TopicListPresenterInterface {
    var called = false
    var showErrorCalled = false
    var results: [TopicListResult] = []
    var nextOffset = -1
    var topicName = ""
    var deviation: DeviantDetailBase?

    func showDeviation(with deviation: DeviantDetailBase) {
        self.deviation = deviation
    }

    func showTopic(with topicName: String) {
        self.topicName = topicName
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with results: [TopicListResult], nextOffset: Int) {
        self.results.append(contentsOf: results)
        self.nextOffset = nextOffset
    }
}
