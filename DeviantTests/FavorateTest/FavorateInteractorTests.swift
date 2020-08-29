//
//  FavorateInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class FavorateInteractorTests: XCTestCase {
    var interactor: FavorateInteractor!
    var presenter: FavoratePresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = FavorateConfiguration(deviationid: DeviantMockData.deviantId )
        interactor = FavorateInteractor(config: configuration)
        presenter = FavoratePresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchFavorates() {
        //Given

        //When
        interactor.tryFetchFavorates(offset: offset)

        //Then
        XCTAssertTrue(presenter.called)
    }
}

class FavoratePresenterSpy: FavoratePresenterInterface {
    func update(with favorates: [FavorateDisplayModel], nextOffset: Int) {
        self.favorates = favorates
    }

    var called = false
    var showErrorCalled = false
    var favorates: [FavorateDisplayModel]?

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }
}
