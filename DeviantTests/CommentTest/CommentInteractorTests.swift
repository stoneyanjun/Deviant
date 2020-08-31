//
//  CommentInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class CommentInteractorTests: XCTestCase {
    var interactor: CommentInteractor!
    var presenter: CommentPresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = CommentConfiguration(deviationid: DeviantMockData.deviantId)
        interactor = CommentInteractor(with: configuration)
        presenter = CommentPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchComments() {
        //Given

        //When
        interactor.tryFetchComments(offset: offset)

        //Then
        XCTAssertTrue(presenter.called)
    }
}

class CommentPresenterSpy: CommentPresenterInterface {
    func update(with comments: [CommentDisplayModel], nextOffset: Int) {
        self.comments = comments
    }

    var called = false
    var showErrorCalled = false
    var comments: [CommentDisplayModel] = []

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }
}
