//
//  DailyListInteractor.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class DailyListInteractor {
    var presenter: DailyListPresenterInterface?
    private(set) var config: DailyListConfiguration

    init(config: DailyListConfiguration) {
        self.config = config
    }
}

extension DailyListInteractor: DailyListInteractorInterface {
    func tryFetchDaily(with date: String) {
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchDaily(with: date)
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            self.fetchDaily(with: date)
        }
    }
}

extension DailyListInteractor {
    private func fetchDaily(with date: String) {
        NetworkManager<BrowseService>().networkRequest(target: .fetchDaily(date: date)) { result in
            switch result {
            case .success(let json):
                guard let dailyBase = JSONDeserializer<DailyBase>.deserializeFrom(json: json.description),
                    let results = dailyBase.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
