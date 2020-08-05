//
//  MoreLikeThisPreview.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct MoreLikeThisPreview: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case author
        case seed
        case moreFromDa = "more_from_da"
        case moreFromArtist = "more_from_artist"
    }

    var author: DeviantDetailAuthor?
    var seed: String?
    var moreFromDa: [DeviantDetailBase]?
    var moreFromArtist: [DeviantDetailBase]?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.moreFromDa <-- CodingKeys.moreFromDa.rawValue
        mapper <<< self.moreFromArtist <-- CodingKeys.moreFromArtist.rawValue
    }
}
