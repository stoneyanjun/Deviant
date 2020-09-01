//
//  DeviantUITests.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import FBSnapshotTestCase
import XCTest

class MPFJourneyUITests: UITestCase {
    override func setUp() {
        super.setUp()
        launchApp(isRecordModel: false)
    }

    func testLaunchJourneyTest() {
        _ = RootSceenModel(self).wait(for: Const.longWaitTime)
            .showPopularPage().wait()
            .verifyView(snapshotKey: .rootPopularList)

            .showDailyPage().wait()
            .verifyView(snapshotKey: .rootDaily)

            .showTopicListPage().wait()
            .verifyView(snapshotKey: .rootTopicList)
            .openFirstTopic().wait(for: Const.longWaitTime)
            .to(TopicDetailScreenModel(self))
            .verifyView(snapshotKey: .topicDetail)
            .showDetail().wait()
            .to(DeviantDetailScreenModel(self))
            .verifyView(snapshotKey: .deviantDetailOfTopic)

            .showMoreInfoPage().wait(for: Const.longWaitTime)
            .verifyView(snapshotKey: .deviantDetailMoreInfo)
            .showInternalCommentPage().wait()
            .verifyView(snapshotKey: .deviantDetailComment)
            .showInternalFavoratePage().wait()
            .verifyView(snapshotKey: .deviantDetailFavorate)
            .showInternalMoreLikePage().wait()
            .verifyView(snapshotKey: .deviantDetailMoreLike)
            .dismissPanModalViewController()
    }
}
