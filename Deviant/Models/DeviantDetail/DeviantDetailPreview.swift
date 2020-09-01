//
//  DeviantDetailPreview.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct DeviantDetailPreview: HandyJSON {
    enum CodingKeys: String, CodingKey {
        case transparency
        case width
        case height
        case src
    }

    var transparency: Bool?
    var width: Int?
    var height: Int?
    var src: String?
}
