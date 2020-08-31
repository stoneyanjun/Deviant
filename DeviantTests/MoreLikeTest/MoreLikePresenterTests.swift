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
        viewController.update(with: moreFromArtist.map { $0.toDisplayModel() },
                              moreFromDa: moreFromDa.map { $0.toDisplayModel() })

        //Then
        XCTAssertEqual(viewController.moreFromArtist.first?.deviationid,
                       DeviantMockData.deviantId)
        XCTAssertEqual(viewController.moreFromDa.first?.deviationid,
                       DeviantMockData.secondDeviantId)
    }
}

class MoreLikeViewControllerSpy: UIViewController, MoreLikeViewControllerInterface {
    func update(with moreFromArtist: [DeviantDetailDisplayModel], moreFromDa: [DeviantDetailDisplayModel]) {
        self.moreFromArtist = moreFromArtist
        self.moreFromDa = moreFromDa
    }

    var called = false
    var showErrorCalled = false
    var moreFromArtist: [DeviantDetailDisplayModel] = []
    var moreFromDa: [DeviantDetailDisplayModel] = []

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func setLoadingView(with status: Bool) {
        called = true
    }
}

class MoreLikeRouterSpy: MoreLikeRouterInterface {
}
