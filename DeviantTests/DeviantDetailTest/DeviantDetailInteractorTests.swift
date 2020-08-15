//
//  DeviantDetailInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class DeviantDetailInteractorTests: XCTestCase {
    var interactor: DeviantDetailInteractor!
    var presenter: DeviantDetailPresenterSpy!

    override func setUp() {
        super.setUp()
        let detailParams = DeviantDetailParams(deviationid: DeviantMockData.deviantId)
        let configuration = DeviantDetailConfiguration(navigationController: nil, detailParams: detailParams)
        interactor = DeviantDetailInteractor(config: configuration)
        presenter = DeviantDetailPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchDeviantDetail() {
        //Given
        presenter.called = false

        //When
        interactor.tryFetchDeviantDetail()

        //Then
        XCTAssertTrue(presenter.called)
    }
}

class DeviantDetailPresenterSpy: DeviantDetailPresenterInterface {
    var called = false
    var showErrorCalled = false
    var deviantDetail: DeviantDetailBase?

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with deviantDetail: DeviantDetailBase) {
        self.deviantDetail = deviantDetail
    }
}
