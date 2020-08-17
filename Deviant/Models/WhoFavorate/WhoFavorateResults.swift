//
//  WhoFavorateResults.swift
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import HandyJSON

struct WhoFavorateResults: HandyJSON {

  enum CodingKeys: String, CodingKey {
    case time
    case user
  }

  var time: Int?
  var user: DeviantUser?
}

extension WhoFavorateResults {
    func toDisplayModel() -> FavorateTableViewCell.ViewData {
        let favorateDate = Date.fromatFavorateDate(with: String(time ?? 0))
        let viewDate = FavorateTableViewCell.ViewData(avatarUrlString: user?.usericon ?? "",
                                                      username: user?.username ?? "",
                                                      favorateDate: favorateDate)
        return viewDate
    }
}
