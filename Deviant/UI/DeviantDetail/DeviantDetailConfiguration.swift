//
//  DeviantDetailConfiguration.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

struct DeviantDetailConfiguration {
    var navigationController: UINavigationController?
    var detailParams: DeviantDetailParams
}

struct DeviantDetailParams {
    var deviationid: String
    var username: String?
    var title: String?
    var favourites: Int?
    var comments: Int?
}
