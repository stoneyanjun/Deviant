//
//  CommentPresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class CommentPresenterTests: XCTestCase {
    var presenter: CommentPresenter!
    var viewController: CommentViewControllerSpy!
    var router: CommentRouterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        presenter = CommentPresenter()
        viewController = CommentViewControllerSpy()
        router = CommentRouterSpy()

        presenter.viewController = viewController
        presenter.router = router
    }

    func testSetLoadingView() {
        //Given
        viewController.called = false

        //When
        presenter.setLoadingView(with: true)

        //Then
        XCTAssertTrue(viewController.called)
    }

    func testShowError() {
        //Given
        viewController.showErrorCalled = false

        //When
        presenter.showError(with: DeviantGeneralError.unknownError)

        //Then
        XCTAssertTrue(viewController.showErrorCalled)
    }

    func testUpdate() {
        //Given
        viewController.comments.removeAll()
        let viewData = DeviantMockData.commentThread.toDisplayModel()

        //When
        viewController.update(with: [viewData], nextOffset: offset)

        //Then
        XCTAssertEqual(viewController.comments.count, 1)
        XCTAssertEqual(viewController.comments.first?.commentId.wrap(), viewData.commentId)
    }
}

class CommentViewControllerSpy: UIViewController, CommentViewControllerInterface {
    var nextOffset = 0
    var called = false
    var showErrorCalled = false
    var comments: [CommentTableViewCell.ViewData] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with comments: [CommentTableViewCell.ViewData], nextOffset: Int) {
        self.comments = comments
    }
}

class CommentRouterSpy: CommentRouterInterface {
}
