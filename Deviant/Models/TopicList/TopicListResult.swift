//
//  TopicListResult.swift
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct TopicListResult: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case exampleDeviations = "example_deviations"
        case name
        case canonicalName = "canonical_name"
        case deviations
    }

    var exampleDeviations: [DeviantDetailBase]?
    var name: String?
    var canonicalName: String?
    var deviations: [DeviantDetailBase]?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.exampleDeviations <-- CodingKeys.exampleDeviations.rawValue
        mapper <<< self.canonicalName <-- CodingKeys.canonicalName.rawValue
    }
}

extension TopicListResult {
    func toDisplayModel() -> TopicListDisplay {
        let deviantDetails = deviations?.map { $0.toDisplayModel() }
        return TopicListDisplay(name: name.wrap(),
                                deviantDetails: deviantDetails)
    }
}
