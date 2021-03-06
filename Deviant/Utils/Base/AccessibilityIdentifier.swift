//
//  AccessibilityIdentifier.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

import UIKit

enum AccessibilityIdentifier: String {
    case commonListCollectionCell
    case popularListCollectionCell
    case moreLikeCollectionCell
    case topicListCollectionCell
    case topicListHeadView
    case topicDetailCollectionCell
    case moreLikeHeadView

    case dailyTableViewCell

    case favorateTableViewCell
    case commentTableViewCell
    case tagCollectionViewCell

    case moreInfoButton
    case commentButton
    case favorateButton
    case moreLikeButton

    func accessibilityIdentifier(row: Int? = nil) -> String {
        var identifier = ""
        for character in rawValue {
            if uppercaseCharacters.contains(character) {
                identifier.append("_")
                identifier.append(String(character).lowercased())
            } else {
                identifier.append(character)
            }
        }

        if let row = row {
            identifier += "_\(row)"
        }
        return identifier
    }
}

private let uppercaseCharacters: [Character] =
    ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
     "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

extension UIAccessibilityIdentification {
    func setAccessibilityIdentifier(_ id: AccessibilityIdentifier,
                                    row: Int? = nil) {
        accessibilityIdentifier = id.accessibilityIdentifier(row: row)
    }
}
