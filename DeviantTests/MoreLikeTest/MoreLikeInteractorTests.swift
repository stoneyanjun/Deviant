//
//  MoreLikeInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class MoreLikeInteractorTests: XCTestCase {
    var interactor: MoreLikeInteractor!
    var presenter: MoreLikePresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = MoreLikeConfiguration()
        interactor = MoreLikeInteractor(config: configuration)
        presenter = MoreLikePresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchMoreLike() {
        //Given

        //When
        interactor.tryFetchMoreLike()

        //Then
        XCTAssertTrue(presenter.called)
    }
}

class MoreLikePresenterSpy: MoreLikePresenterInterface {
    var called = false
    var showErrorCalled = false
    var moreFromArtist: [DeviantDetailBase] = []
    var moreFromDa: [DeviantDetailBase] = []

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with moreFromArtist: [DeviantDetailBase], moreFromDa: [DeviantDetailBase]) {
        self.moreFromArtist = moreFromArtist
        self.moreFromDa = moreFromDa
    }
}
