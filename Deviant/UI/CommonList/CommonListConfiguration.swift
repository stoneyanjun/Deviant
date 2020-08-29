//
//  CommonListConfiguration.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

enum ListType {
    case popularList
    case topicDetail(_ topicName: String)
}

struct CommonListConfiguration {
    var navigationController: UINavigationController?
    var listType: ListType
}
