//
//  MockDataManager.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

enum MockDataType {
    case token
    case popularLlist
    case topicList
    case daily
    case topicDetail
    case deviantDetail
    case metadata
    case comment
    case favorate
    case moreLike
}

class MockDataManager: NSObject {
    static let shared = MockDataManager()

    override private init() {
        super.init()
    }

    func getMockData(type: MockDataType) -> Data {
        var jsonFileName = ""
        switch type {
        case .token:
            jsonFileName = "Token"
        case .popularLlist:
            jsonFileName = "PopularList"
        case .topicList:
            jsonFileName = "TopicList"
        case .daily:
            jsonFileName = "Daily"
        case .topicDetail:
            jsonFileName = "topicDetail"
        case .deviantDetail:
            jsonFileName = "DeviantDetail"
        case .metadata:
            jsonFileName = "Metadata"
        case .comment:
            jsonFileName = "Comment"
        case .favorate:
            jsonFileName = "WhoFavorate"
        case .moreLike:
            jsonFileName = "MoreLike"
        }

        guard let jsonPath = Bundle.main.path(forResource: jsonFileName, ofType: "json") else {
            return Data()
        }

        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
            return jsonData
        } else {
            return Data()
        }
    }
}
