//
//  DeviantDetailInteractor.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class DeviantDetailInteractor {
    var presenter: DeviantDetailPresenterInterface?
    private(set) var config: DeviantDetailConfiguration

    init(config: DeviantDetailConfiguration) {
        self.config = config
    }
}

extension DeviantDetailInteractor: DeviantDetailInteractorInterface {
    func tryFetchDeviantDetail() {
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchDeviantDetail()
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            self.fetchDeviantDetail()
        }
    }
}

extension DeviantDetailInteractor {
    private func fetchDeviantDetail() {
        NetworkManager<DeviantService>().networkRequest(target: .fetchDeviantDetail(deviationid: config.detailParams.deviationid)) { result in
            switch result {
            case .success(let json):
                print(#function + "\r\n\(json.description)")
                guard let deviantDetailBase = JSONDeserializer<DeviantDetailBase>.deserializeFrom(json: json.description)
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: deviantDetailBase)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
