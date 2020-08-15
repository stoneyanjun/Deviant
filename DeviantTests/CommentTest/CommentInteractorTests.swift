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
        let configuration = CommentConfiguration()
        interactor = CommentInteractor(config: configuration)
        presenter = CommentPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchComments() {
        //Given

        //When
        interactor.tryFetchComments()

        //Then
        XCTAssertTrue(presenter.called)
    }
}

class CommentPresenterSpy: CommentPresenterInterface {
    var called = false
    var showErrorCalled = false
    var comment: CommentBase?

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with comment: CommentBase) {
        self.comment = comment
    }
}
