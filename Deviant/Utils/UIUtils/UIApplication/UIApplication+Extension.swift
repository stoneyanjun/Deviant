//
//  UIApplication+Extension.swift
//  Deviant
//
//  Created by Stone on 18/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    // swiftlint:disable:next cyclomatic_complexity
    func fontScaleFactor() -> CGFloat {
        switch preferredContentSizeCategory {
        case UIContentSizeCategory.extraSmall:
            return 0.7
        case UIContentSizeCategory.small:
            return 0.85
        case UIContentSizeCategory.medium:
            return 0.9
        case UIContentSizeCategory.large: // default
            return 1.0
        case UIContentSizeCategory.extraLarge:
            return 1.1
        case UIContentSizeCategory.extraExtraLarge:
            return 1.2
        case UIContentSizeCategory.extraExtraExtraLarge:
            return 1.3
        case UIContentSizeCategory.accessibilityMedium:
            return 1.4
        case UIContentSizeCategory.accessibilityLarge:
            return 1.5
        case UIContentSizeCategory.accessibilityExtraLarge:
            return 1.6
        case UIContentSizeCategory.accessibilityExtraExtraLarge:
            return 1.7
        case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            return 1.8
        default:
            return 1.0
        }
    }
}
