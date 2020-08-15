//
//  DeviantFailure.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation

enum DeviantFailure: Error {
    case devFailure(_ error: Error)
}

struct DeviantGeneralError: Error {
    enum ErrorType: String {
        case network
        case unknown
        case oauth
    }

    var errorType: ErrorType = .unknown {
        didSet {
            if errorDescription == nil {
                errorDescription = defaultDescription()
            }
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
        if case .devFailure(let error) = self as? DeviantFailure {
            if let mpfError = error as? DeviantGeneralError {
                return mpfError
            }
        }
        return DeviantGeneralError.unknownError
    }
}

extension DeviantGeneralError {
    var localizedDescription: String {
        if let errorDescription = self.errorDescription {
            return errorDescription
        }
        return defaultDescription()
    }
}
