//
//  DeviantError.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation

enum DeviantError: Error {
    case failure(_ error: Error)
}

struct DeviantGeneralError: Error {
    enum ErrorType: String {
        case network
        case unknown
        case oauth
    }

    var errorType: ErrorType = .unknown {
        didSet {
            errorDescription = defaultDescription()
        }
    }
    var error: String?
    var errorDescription: String?

    private func defaultDescription() -> String {
        switch errorType {
        case .network:
            return "Fail to connect server!"
        default:
            return "Unkown error!"
        }
    }

    static let oauthError = DeviantGeneralError(errorType: .oauth)
    static let unknownError = DeviantGeneralError(errorType: .unknown)
    static let networkError = DeviantGeneralError(errorType: .network)
}

extension Error {
    var deviantError: DeviantGeneralError {
        if case .failure(let error) = self as? DeviantError {
            if let mpfError = error as? DeviantGeneralError {
                return mpfError
            }
        }
        return DeviantGeneralError.unknownError
    }
}
