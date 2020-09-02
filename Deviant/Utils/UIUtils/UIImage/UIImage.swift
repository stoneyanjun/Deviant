//
//  UIImage.swift
//  Deviant
//
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

enum ImageKey: String {
    case back

    case bigEmpty
    case bigInfo
    case bigLoading
    case bigMore
    case bigStarWhite
    case bigCommentWhite

    case commentAvatar
    case eyeView
    case starWhite
    case commentWhite

    func image() -> UIImage? {
        switch self {
        default:
            return UIImage(named: rawValue)
        }
    }
}
