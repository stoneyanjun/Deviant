//
//  DeviantDetailConfiguration.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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
