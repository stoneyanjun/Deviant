//
//  TopicDetailInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class TopicDetailInteractorTests: XCTestCase {
    var interactor: TopicDetailInteractor!
    var presenter: TopicDetailPresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = TopicDetailConfiguration(navigationController: nil, topicName: DeviantMockData.topicName)
        interactor = TopicDetailInteractor(config: configuration)
        presenter = TopicDetailPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchTopic() {
        //Given"
        offset = 0
        presenter.called = false

        //When
        interactor.tryFetchTopic(with: offset)

        //Then
        XCTAssertTrue(presenter.called)
    }

    func testShowDeviation() {
        //Given

        //When
        interactor.showDeviation(with: DeviantMockData.detail)

        //Then
        XCTAssertEqual(DeviantMockData.deviantId,
                       presenter.topicDetail?.deviationid.wrap())
    }
}

class TopicDetailPresenterSpy: TopicDetailPresenterInterface {
    var called = false
    var showErrorCalled = false
    var results: [DeviantDetailBase] = []
    var topicDetail: DeviantDetailBase?
    var nextOffset = -1

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with results: [DeviantDetailBase], nextOffset: Int) {
        self.results.append(contentsOf: results)
        self.nextOffset = nextOffset
    }

    func showDeviation(with topicDetail: DeviantDetailBase) {
        self.topicDetail = topicDetail
    }
}
