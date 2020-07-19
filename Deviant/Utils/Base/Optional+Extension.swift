//
//  Optional+Extension.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    func wrap(_ defaultValue: String = "") -> Wrapped {
        switch self {
        case .none:
            return defaultValue
        case .some(let value):
            return value
        }
    }
}
