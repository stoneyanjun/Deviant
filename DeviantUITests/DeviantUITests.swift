//
//  DeviantUITests.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import FBSnapshotTestCase
import XCTest

/*
class DeviantUITests: FBSnapshotTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

//        recordMode = true
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
     */

class MPFJourneyUITests: UITestCase {
    override func setUp() {
        super.setUp()
        launchApp(isRecordModel: false)
    }

    func testLaunchJourneyTest() {
        print(#function)
        _ = RootSceenModel(self).longerWait()
            .showPopularPage().wait()
            .verifyView(snapshotKey: .rootPopularList)
            .showDetail().longerWait()

            .verifyView(snapshotKey: .popularDeviantDetail)
            .goBack().wait()

            .showDailyPage().wait()
            .verifyView(snapshotKey: .rootDaily)
            .showDetail().longerWait()
            .verifyView(snapshotKey: .dailyDeviantDetail)
            .goBack().wait()

            .showTopicListPage().wait()
            .verifyView(snapshotKey: .rootTopicList)
            .showTopic().longerWait()
            .verifyView(snapshotKey: .topicDetail)
            .to(TopicDetailScreenModel(self))
            .showDetail().longerWait()

            .verifyView(snapshotKey: .deviantDetail)
            .to(DeviantDetailScreenModel(self))
            .showMoreInfoPage().longerWait()
            .verifyView(snapshotKey: .deviantDetailMoreInfo)
            .showInternalCommentPage().wait()
            .verifyView(snapshotKey: .deviantDetailComment)
            .showInternalFavoratePage().wait()
            .verifyView(snapshotKey: .deviantDetailFavorate)
            .showInternalMoreLikePage().wait()
            .verifyView(snapshotKey: .deviantDetailMoreLike)

    }
}
//
