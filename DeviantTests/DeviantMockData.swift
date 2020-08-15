//
//  DeviantMockData.swift
//  DeviantTests
//
//  Copyright © 2020 Stone. All rights reserved.
//

@testable import Deviant
import Foundation
import XCTest

struct DeviantMockData {
    static let deviantId = "001"
    static let userid = "D4FE00D1-26F8-8989-B813-D4018CF554CC"
    static let usericon = "https://a.deviantart.net/avatars/k/e/keid.jpg?14"
    static let src = "https://images.wixm"
    static let username = "Keid"
    static let body = "<a href=\"https:Body"
    static let comments = 11
    static let favourites = 22
    static let deviantTitle = "deviant title"
    static let category = "Visual Art"
    static let categoryPath = "visual_art"
    static let width = 100
    static let height = 200
    static let fileSize = 3000
    static let authorType = "regular"
    static let url = "https:\\xxx"
    static let giverType = "volunteer"
    static let deviantTime = "2020-06-12T00:00:00-0700"
    static let publishedTime = "1591291314"
    static let topicName = "test TopicName"
    static let canonicalName = "test canonicalName"

    static let author = DeviantDetailAuthor(type: authorType,
                                            usericon: usericon,
                                            userid: userid,
                                            username: username)

    static let content = DeviantDetailContent(height: height,
                                              src: src,
                                              filesize: fileSize,
                                              transparency: false,
                                              width: width)

    static let giver = DeviantDetailGiver(userid: userid,
                                          type: giverType,
                                          usericon: usericon,
                                          username: username)

    static let  dailyDeviant = DeviantDetailDailyDeviation(time: deviantTime,
                                                           giver: giver,
                                                           body: body)

    static let stats = DeviantDetailStats(comments: comments,
                                          favourites: favourites)

    static let thumb = DeviantDetailThumb(transparency: true,
                                          width: width,
                                          src: src,
                                          height: height)

    static let preview = DeviantDetailPreview(transparency: false,
                                              width: width,
                                              height: height,
                                              src: src)

    static let detail = DeviantDetailBase(allowsComments: true,
                                          deviationid: deviantId,
                                          author: author,
                                          content: content,
                                          dailyDeviation: dailyDeviant,
                                          url: url,
                                          stats: stats,
                                          isDeleted: true,
                                          title: deviantTitle,
                                          isDownloadable: true,
                                          isMature: true,
                                          thumbs: [thumb],
                                          downloadFilesize: fileSize,
                                          category: category,
                                          preview: preview,
                                          categoryPath: categoryPath,
                                          publishedTime: publishedTime,
                                          isFavourited: false)

    static let topicListResult = TopicListResult(exampleDeviations: [detail],
                                                 name: topicName,
                                                 canonicalName: canonicalName,
                                                 deviations: [detail])
}
