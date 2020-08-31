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
        let configuration = MoreLikeConfiguration(deviationid: DeviantMockData.deviantId )
        interactor = MoreLikeInteractor(with: configuration)
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
    var moreFromArtist: [DeviantDetailDisplayModel] = []
    var moreFromDa: [DeviantDetailDisplayModel] = []

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with moreFromArtist: [DeviantDetailDisplayModel], moreFromDa: [DeviantDetailDisplayModel]) {
        self.moreFromArtist = moreFromArtist
        self.moreFromDa = moreFromDa
    }
}
