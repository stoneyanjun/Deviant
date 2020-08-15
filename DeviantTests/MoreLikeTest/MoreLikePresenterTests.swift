//
//  MoreLikePresenterTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class MoreLikePresenterTests: XCTestCase {
    var presenter: MoreLikePresenter!
    var viewController: MoreLikeViewControllerSpy!
    var router: MoreLikeRouterSpy!

    override func setUp() {
        super.setUp()
        presenter = MoreLikePresenter()
        viewController = MoreLikeViewControllerSpy()
        router = MoreLikeRouterSpy()

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
        viewController.moreFromArtist.removeAll()
        viewController.moreFromDa.removeAll()
        let moreFromArtist = [DeviantMockData.detail]
        let moreFromDa = [DeviantMockData.secondDetail]

        //When
        viewController.update(with: moreFromArtist, moreFromDa: moreFromDa)

        //Then
        XCTAssertEqual(viewController.moreFromArtist.first?.deviationid.wrap(),
                       DeviantMockData.deviantId)
        XCTAssertEqual(viewController.moreFromDa.first?.deviationid.wrap(),
                       DeviantMockData.secondDeviantId)
    }
}

class MoreLikeViewControllerSpy: UIViewController, MoreLikeViewControllerInterface {
    var called = false
    var showErrorCalled = false
    var moreFromArtist: [DeviantDetailBase] = []
    var moreFromDa: [DeviantDetailBase] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }

    func update(with moreFromArtist: [DeviantDetailBase], moreFromDa: [DeviantDetailBase]) {
        self.moreFromArtist = moreFromArtist
        self.moreFromDa = moreFromDa
    }
}

class MoreLikeRouterSpy: MoreLikeRouterInterface {
}
