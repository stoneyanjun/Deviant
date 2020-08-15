//
//  Optional+Extension.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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
