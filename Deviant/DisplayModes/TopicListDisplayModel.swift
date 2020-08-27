//
//  DeviantDetailDisplayModel.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

protocol TopicListDisplayModel {
    var name: String { get }
    var deviantDetails: [DeviantDetailDisplayModel]? { get }
}

struct TopicListDisplay: TopicListDisplayModel {
    var name: String
    var deviantDetails: [DeviantDetailDisplayModel]?
}
