//
//  DeviantDetailDisplayModel.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

protocol DeviantDetailDisplayModel {
    var deviationid: String { get }
    var title: String? { get }
    var username: String? { get }
    var src: String? { get }
    var width: Int? { get }
    var height: Int? { get }
}

struct DeviantDetailDisplay: DeviantDetailDisplayModel {
    var deviationid: String
    var title: String?
    var username: String?
    var src: String?
    var width: Int?
    var height: Int?
}
