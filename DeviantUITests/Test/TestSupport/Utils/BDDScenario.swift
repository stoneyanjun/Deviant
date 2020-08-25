//
//  BDDScenario.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

public enum BDDStepType: String, Comparable, CaseIterable {
    case reference = "reference: //"
    case given
    case when
    case and
    case then

    private var index: Int {
        guard let index = BDDStepType.allCases.firstIndex(of: self) else {
            fatalError("Inconsistent error")
        }
        return index
    }

    public static func < (lhs: BDDStepType, rhs: BDDStepType) -> Bool {
        lhs.index < rhs.index
    }
}

public struct BDDScenario: CustomStringConvertible {
    public typealias BDDStep = (type: BDDStepType, message: String)

    var steps: [BDDStep]

    public static func scenario(_ steps: BDDStep ...) -> BDDScenario {
        BDDScenario(steps: steps)
    }

    public var description: String {
        "<BDDScenario>\(steps.sorted { $0.type < $1.type }.reduce("") { "\($0)\($1.type.rawValue.uppercased()) \($1.message) |" })</BDDScenario>"
    }
}
