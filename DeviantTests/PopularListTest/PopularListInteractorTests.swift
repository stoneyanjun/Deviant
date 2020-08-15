//
//  PopularListInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class PopularListInteractorTests: XCTestCase {
    var interactor: PopularListInteractor!
    var presenter: PopularListPresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = PopularListConfiguration()
        interactor = PopularListInteractor(config: configuration)
        presenter = PopularListPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchPopular() {
        //Given
        presenter.called = false

        //When
        interactor.tryFetchPopular(with: self.offset)

        //Then
        XCTAssertTrue(presenter.called)
    }

    func testShowDeviation() {
        //Given
        let base = DeviantDetailBase()
        presenter.showDeviationCalled = false

        //When
        interactor.showDeviation(with: base)

        //Then
        XCTAssertTrue(presenter.showDeviationCalled)
    }
}

class PopularListPresenterSpy: PopularListPresenterInterface {
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

    func update(with results: [DeviantDetailBase], nextOffset: Int) {
        updateCalled = true
    }

    func showDeviation(with popularResult: DeviantDetailBase) {
        showDeviationCalled = true
    }
}
