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
