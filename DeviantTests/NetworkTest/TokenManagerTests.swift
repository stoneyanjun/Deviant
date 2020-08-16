//
//  MetadataInteractorTests.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

class TokenManagerTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    func testFetchToken() {
        let expectation = self.expectation(description: "Waiting on token fetching")
        TokenManager.shared.fetchToken { result in
            expectation.fulfill()
            switch result {
            case .success(let token):
                print(#function + "token: \(token)")
                XCTAssertTrue(!token.isEmpty)
            case .failure(let error):
                print(#function + "error: \(error.localizedDescription)")
                XCTAssertTrue(!error.localizedDescription.isEmpty)
            }
        }

        waitForExpectations(timeout: NetworkConst.testTimeout, handler: nil)
    }
}
