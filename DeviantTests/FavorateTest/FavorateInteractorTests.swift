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
        let configuration = FavorateConfiguration()
        interactor = FavorateInteractor(config: configuration)
        presenter = FavoratePresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchFavorates() {
        //Given

        //When
        interactor.tryFetchFavorates()

        //Then
        XCTAssertTrue(presenter.called)
    }
}

class FavoratePresenterSpy: FavoratePresenterInterface {
    var called = false
    var showErrorCalled = false
    var favorate: WhoFavorateBase?

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with favorate: WhoFavorateBase) {
        self.favorate = favorate
    }
}
