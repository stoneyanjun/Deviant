//
//  AccessibilityIdentifier.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

import UIKit

enum AccessibilityIdentifier: String {
    case popularListCollectionCell
    case moreLikeCollectionCell
    case topicListCollectionCell
    case topicListHeadView
    case moreLikeHeadView
    case topicDetailCollectionCell

    case dailyTableViewCell

    case favorateTableViewCell
    case commentTableViewCell
    case tagCollectionViewCell

    case moreInfoButton
    case commentButton
    case favorateButton
    case moreLikeButton

    func accessibilityIdentifier(status: AccessibilityStatus = .none, row: Int? = nil) -> String {
        var identifier = ""
        for character in rawValue {
            if uppercaseCharacters.contains(character) {
                identifier.append("_")
                identifier.append(String(character).lowercased())
            } else {
                identifier.append(character)
            }
        }
        if !status.rawValue.isEmpty {
            identifier += "_\(status.rawValue)"
        }

        if let row = row {
            identifier += "_\(row)"
        }
        return identifier
    }
}

enum AccessibilityStatus: String {
    case none = ""
    case up
    case down
    case selected
}

private let uppercaseCharacters: [Character] =
    ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

extension UIAccessibilityIdentification {
    func setAccessibilityIdentifier(_ id: AccessibilityIdentifier,
                                    status: AccessibilityStatus = .none,
                                    row: Int? = nil) {
        accessibilityIdentifier = id.accessibilityIdentifier(status: status, row: row)
    }
}
