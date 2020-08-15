//
//  MetadataInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class MetadataInteractorTests: XCTestCase {
    var interactor: MetadataInteractor!
    var presenter: MetadataPresenterSpy!
    var offset = 0

    override func setUp() {
        super.setUp()
        let configuration = MetadataConfiguration()
        interactor = MetadataInteractor(config: configuration)
        presenter = MetadataPresenterSpy()
        interactor.presenter = presenter
    }

    func testTryFetchMetadatas() {
        //Given

        //When
        interactor.tryFetchMetadata()

        //Then
        XCTAssertTrue(presenter.called)
    }
}

class MetadataPresenterSpy: MetadataPresenterInterface {
    var called = false
    var showErrorCalled = false
    var meta: MetadataBase?

    func setLoadingView(with status: Bool) {
        called = true
    }

    func showError(with error: Error) {
        showErrorCalled = true
    }

    func update(with meta: MetadataBase) {
        self.meta = meta
    }
}
