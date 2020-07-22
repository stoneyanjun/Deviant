//
//  TopicListResults.swift
//
//  Created by Stone on 23/7/2020
//  Copyright (c) . All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListResults: HandyJSON {

    enum CodingKeys: String, CodingKey {
        case exampleDeviations = "example_deviations"
        case name
        case canonicalName = "canonical_name"
        case deviations
    }

    var exampleDeviations: [TopicListExampleDeviations]?
    var name: String?
    var canonicalName: String?
    var deviations: [TopicListDeviations]?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.exampleDeviations <-- CodingKeys.exampleDeviations.rawValue
        mapper <<< self.canonicalName <-- CodingKeys.canonicalName.rawValue
    }
}
