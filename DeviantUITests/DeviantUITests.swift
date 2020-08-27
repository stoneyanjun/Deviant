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
        launchApp(isRecordModel: true)
    }

    func testLaunchJourneyTest() {
        _ = RootSceenModel(self).longerWait()
            .showPopularPage().wait()
            .verifyView(snapshotKey: .rootPopularList)
            .openFirstPopularItem().longerWait()
            .verifyView(snapshotKey: .popularDeviantDetail)

            .to(DeviantDetailScreenModel(self))
            .showMoreInfoPage().longerWait()
            .verifyView(snapshotKey: .deviantDetailMoreInfo)
            .showInternalCommentPage().wait()
            .verifyView(snapshotKey: .deviantDetailComment)
            .showInternalFavoratePage().wait()
            .verifyView(snapshotKey: .deviantDetailFavorate)
            .showInternalMoreLikePage().wait()
            .verifyView(snapshotKey: .deviantDetailMoreLike)

            .swipeDownVC()
            .goBack().wait()

            .to(RootSceenModel(self))
            .showDailyPage().wait()
            .verifyView(snapshotKey: .rootDaily)
            .openFirstDaily().longerWait()
            .verifyView(snapshotKey: .dailyDeviantDetail)
            .goBack().wait()

            .to(RootSceenModel(self))
            .showTopicListPage().wait()
            .verifyView(snapshotKey: .rootTopicList)
            .openFirstTopic().longerWait()
            .verifyView(snapshotKey: .topicDetail)
            .to(TopicDetailScreenModel(self))
            .showDetail().longerWait()
    }
}
