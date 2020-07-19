//
//  DeviantError.swift
//  Deviant
//
//  Created by Stone on 19/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Foundation
import HandyJSON

struct TokenBase: HandyJSON {
    enum CodingKeys: String {
        case status
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
    }

    var status: String?
    var tokenType: String?
    var expiresIn: Int?
    var accessToken: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.tokenType <-- CodingKeys.tokenType.rawValue
        mapper <<< self.expiresIn <-- CodingKeys.expiresIn.rawValue
        mapper <<< self.accessToken <-- CodingKeys.accessToken.rawValue
    }
}
