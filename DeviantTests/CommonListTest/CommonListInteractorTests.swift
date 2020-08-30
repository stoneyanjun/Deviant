//
//  CommonListInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class CommonListInteractorTests: XCTestCase {
    var interactor: CommonListInteractor!
    var presenter: CommonListPresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
    }

    func testTryFetchPopular() {
        //Given
        let configuration = CommonListConfiguration(listType: .popularList)
        interactor = CommonListInteractor(config: configuration)
        presenter = CommonListPresenterSpy()
        interactor.presenter = presenter

        presenter.called = false
        let offset = 0

        //When
        interactor.tryFetchList(with: offset)
        //Then
        XCTAssertTrue(presenter.called)
    }

    func testTryFetchTopicDetail() {
        //Given
        let topicName = DeviantMockData.topicName
        let configuration = CommonListConfiguration(listType: .topicDetail(topicName))
        interactor = CommonListInteractor(config: configuration)
        presenter = CommonListPresenterSpy()
        interactor.presenter = presenter

        presenter.called = false
        let offset = 0

        //When
        interactor.tryFetchList(with: offset)
        //Then
        XCTAssertTrue(presenter.called)
    }

    func testShowDeviation() {
        //Given
        let configuration = CommonListConfiguration(listType: .popularList)
        interactor = CommonListInteractor(config: configuration)
        presenter = CommonListPresenterSpy()
        interactor.presenter = presenter

        let base = DeviantDetailDisplayModel(deviationid: DeviantMockData.deviantId)
        presenter.showDeviationCalled = false

        //When
        interactor.showDeviation(with: base)

        //Then
        XCTAssertTrue(presenter.showDeviationCalled)
    }
}

class CommonListPresenterSpy: CommonListPresenterInterface {
    var called = false
    var showErrorCalled = false
    var updateCalled = false
    var showDeviationCalled = false

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with results: [DeviantDetailDisplayModel], nextOffset: Int) {
        updateCalled = true
    }

    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        showDeviationCalled = true
    }
}
