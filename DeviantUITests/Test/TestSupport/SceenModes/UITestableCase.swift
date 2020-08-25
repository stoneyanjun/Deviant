//
//  UITestableCase.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

public typealias UITestableCase = UITestable & XCTestCase

public protocol UITestable {
    var app: XCUIApplication { get }
}

public protocol Localizable {
    var locale: Locale { get }
}

extension UITestable {
    public func makeLaunchArguments(localizable: Localizable,
                                    userInterfaceStyle: UIUserInterfaceStyle) -> [String] {
        let argumentTemplate =  "-AppleLanguages (%@) -AppleLocale %@ -AppleInterfaceStyle %@"
        let localeIdentifier = localizable.locale.identifier
        let lang = localizable.locale.languageCode ?? localeIdentifier

        let interfaceStyle: String
        switch userInterfaceStyle {
        case .unspecified, .light:
            interfaceStyle = "Light"
        case .dark:
            interfaceStyle = "Dark"
        @unknown default:
            interfaceStyle = "Light"
        }

        let rawArguments = String(format: argumentTemplate,
                                  lang,
                                  localeIdentifier,
                                  interfaceStyle)
        return rawArguments.split(separator: " ").map(String.init)
    }
}
