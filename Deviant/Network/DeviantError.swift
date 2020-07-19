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

enum DeviantErrorType {
    case network
    case unknown
    case
}
struct DeviantGeneralError: Error {
    enum ErrorType {
        case network
        case unknown
    }

    var errorCode: String?
    var errorType:
    var localizedDescription: String {
        switch errorCode {
        case .noAccountInfo:
            return "Fail to get access token"
        case .unknownError:
            return "Unknown error"
        default:
            return "Unknown error"
        }
    }

    static let accountError = DeviantGeneralError(errorCode: ErrorCode.noAccountInfo)
    static let unknownError = DeviantGeneralError(errorCode: ErrorCode.noAccountInfo)
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
