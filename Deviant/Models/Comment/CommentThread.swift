//
//  CommentThread.swift
//
//  Created by Stone on 4/8/2020
//  Copyright (c) . All rights reserved.
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
    var user: CommentUser?
    var commentid: String?
    var posted: String?
}

extension CommentThread {
    func toDisplayModel() -> CommentTableViewCell.ViewData {
        let postedDate = Date.fromatPostedDate(postedDateStr: posted.wrap())
        let viewDate = CommentTableViewCell.ViewData(avatarUrlString: user?.usericon, username: user?.username ?? "", postedDate: postedDate, comment: getCommentFromBody())

        return viewDate
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
