//
//  DailyListInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class DailyListInteractorTests: XCTestCase {
    var interactor: DailyListInteractor!
    var presenter: DailyListPresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = DailyListConfiguration()
        interactor = DailyListInteractor(config: configuration)
        presenter = DailyListPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchDaily() {
        //Given"
        let date = ""
        presenter.called = false

        //When
        interactor.tryFetchDaily(with: date)

        //Then
        XCTAssertTrue(presenter.called)
    }

    func testShowDeviation() {
        //Given

        //When
        interactor.showDeviation(with: DeviantMockData.detail.toDisplayModel())

        //Then
        XCTAssertEqual(DeviantMockData.deviantId,
                       presenter.dailyResult?.deviationid)
    }
}

class DailyListPresenterSpy: DailyListPresenterInterface {
    func update(with results: [DeviantDetailDisplayModel]) {
        self.results.append(contentsOf: results)
    }

    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        self.dailyResult = deviantDetail
    }

    var called = false
    var showErrorCalled = false
    var results: [DeviantDetailDisplayModel] = []
    var dailyResult: DeviantDetailDisplayModel?

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }
}
