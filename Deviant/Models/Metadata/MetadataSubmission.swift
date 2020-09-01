//
//  MetadataSubmission.swift
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct MetadataSubmission: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case resolution
        case submittedWith = "submitted_with"
        case fileSize = "file_size"
        case category
        case creationTime = "creation_time"
    }

    var resolution: String?
    var submittedWith: MetadataSubmittedWith?
    var fileSize: String?
    var category: String?
    var creationTime: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.submittedWith <-- CodingKeys.submittedWith.rawValue
        mapper <<< self.fileSize <-- CodingKeys.fileSize.rawValue
        mapper <<< self.creationTime <-- CodingKeys.creationTime.rawValue
    }
}
