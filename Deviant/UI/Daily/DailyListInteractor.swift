//
//  DailyListInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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
        presenter?.setLoadingView(with: true)
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

    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        presenter?.showDeviation(with: deviantDetail)
    }
}

extension DailyListInteractor {
    private func fetchDaily(with date: String) {
        presenter?.setLoadingView(with: true)
        NetworkManager<DeviantService>().networkRequest(target: .fetchDaily(date: date)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
//                print(#function + " json\r\n\(json.description)")
                #endif
                guard let dailyBase = JSONDeserializer<DailyBase>.deserializeFrom(json: json.description),
                    let results = dailyBase.results
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: results.map { $0.toDisplayModel() })
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
