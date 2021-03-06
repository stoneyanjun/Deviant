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
    static let deviantId = "D08DE65F-FC99-B804-35B9-87655550B740"
    static let secondDeviantId = "B69A9A86-B509-EEB7-E4F6-ED562CD55F76"
    static let userid = "D4FE00D1-26F8-8989-B813-D4018CF554CC"
    static let secondUserid = "1185483A-EE52-5BB6-D81F-45190908B1C4"
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
    static let submissionFileSize = "1.0 MB"
    static let authorType = "regular"
    static let url = "https:\\xxx"
    static let giverType = "volunteer"
    static let dateTime = "2020-06-12T00:00:00-0700"
    static let timeStamp = "1591291314"
    static let topicName = "Visual Art"
    static let canonicalName = "test canonicalName"
    static let replies = 11
    static let hidden = "hidden_as_spam"
    static let commentid = "D16748FE-F408-CAFE-26BB-03F322825D7D"
    static let sponsored = false
    static let tagName = "portfolio"
    static let sponsor = "sponsor name"
    static let downloadsToday = 3
    static let downloads = 30
    static let viewsToday = 11
    static let views = 121
    static let app = "DeviantArt"
    static let resolution = "3508x2480"
    static let descriptionValue = "www.javiergonzalezart.com"
    static let license = "No License"

    static let user = DeviantUser(type: authorType,
                                  usericon: usericon,
                                  userid: userid,
                                  username: username)

    static let secondUser = DeviantUser(type: giverType,
                                        usericon: usericon,
                                        userid: secondUserid,
                                        username: username)

    static let content = DeviantDetailContent(height: height,
                                              src: src,
                                              filesize: fileSize,
                                              transparency: false,
                                              width: width)

    static let  dailyDeviant = DeviantDetailDailyDeviation(time: dateTime,
                                                           giver: secondUser,
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
                                          author: user,
                                          content: content,
                                          dailyDeviation: dailyDeviant,
                                          url: url,
                                          stats: stats,
                                          isDeleted: false,
                                          title: deviantTitle,
                                          isDownloadable: false,
                                          isMature: false,
                                          thumbs: [thumb],
                                          downloadFilesize: fileSize,
                                          category: category,
                                          preview: preview,
                                          categoryPath: categoryPath,
                                          publishedTime: timeStamp,
                                          isFavourited: false)

    static let secondDetail = DeviantDetailBase(allowsComments: true,
                                                deviationid: secondDeviantId,
                                                author: user,
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
                                                publishedTime: timeStamp,
                                                isFavourited: false)

    static let topicListResult = TopicListResult(exampleDeviations: [detail],
                                                 name: topicName,
                                                 canonicalName: canonicalName,
                                                 deviations: [detail])

    static let commentThread = CommentThread(replies: replies,
                                             hidden: hidden,
                                             body: body,
                                             user: user,
                                             commentid: commentid,
                                             posted: dateTime)

    static let tag = MetadataTags(sponsor: sponsor,
                                  tagName: tagName,
                                  sponsored: sponsored)

    static let metadataStats = MetadataStats(favourites: favourites,
                                             downloadsToday: downloadsToday,
                                             comments: comments,
                                             downloads: downloads,
                                             viewsToday: viewsToday,
                                             views: views)

    static let metadataSubmittedWith = MetadataSubmittedWith(url: url,
                                                             app: app)

    static let metadataSubmission = MetadataSubmission(resolution: resolution,
                                                       submittedWith: metadataSubmittedWith,
                                                       fileSize: submissionFileSize,
                                                       category: category,
                                                       creationTime: dateTime)

    static let metadata = MetadataMetadata(tags: [tag],
                                           deviationid: deviantId,
                                           descriptionValue: descriptionValue,
                                           stats: metadataStats,
                                           allowsComments: true,
                                           isMature: false,
                                           isFavourited: false,
                                           title: deviantTitle,
                                           license: license,
                                           isWatching: false,
                                           author: user,
                                           submission: metadataSubmission)

    static let metadataBase = MetadataBase(metadata: [metadata])

    static let favorate = WhoFavorateModel(time: (timeStamp.int ?? 0),
                                           user: secondUser)
}
