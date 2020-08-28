//
//  CommentThread.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftSoup

struct CommentThread: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case replies
        case hidden
        case body
        case user
        case commentid
        case posted
    }

    var replies: Int?
    var hidden: String?
    var body: String?
    var user: DeviantUser?
    var commentid: String?
    var posted: String?
}

extension CommentThread {
    func toDisplayModel() -> CommentDisplayModel {
        let postedDate = Date.fromatPostedDate(postedDateStr: posted.wrap())
        let displayModel = CommentDisplayModel(avatarUrlString: user?.usericon,
                                               username: user?.username ?? "",
                                               postedDate: postedDate,
                                               comment: getCommentFromBody(),
                                               commentId: commentid)

        return displayModel
    }

    func getCommentFromBody() -> String {
        guard let body = self.body else {
            return ""
        }
        do {
            let doc: Document = try parse(body)
            return try doc.text()
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
}
