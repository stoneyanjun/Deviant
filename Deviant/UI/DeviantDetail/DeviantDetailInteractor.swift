//
//  DeviantDetailInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class DeviantDetailInteractor {
    var presenter: DeviantDetailPresenterInterface?
    private(set) var config: DeviantDetailConfiguration

    init(with configuration: DeviantDetailConfiguration) {
        config = configuration
    }
}

extension DeviantDetailInteractor: DeviantDetailInteractorInterface {
    func tryFetchDeviantDetail() {
        self.presenter?.setLoadingView(with: true)
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

    func showMoreDetail(with deviantDetail: DeviantDetailDisplayModel, tag: Int) {
        presenter?.showMoreDetail(with: deviantDetail, tag: tag)
    }
}

extension DeviantDetailInteractor {
    private func fetchDeviantDetail() {
        NetworkManager<DeviantService>().networkRequest(target:
        .fetchDeviantDetail(deviationid: config.detailParams.deviationid)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
//                print(#function + " json\r\n\(json.description)")
                #endif
                guard let detailBase = JSONDeserializer<DeviantDetailBase>.deserializeFrom(json: json.description)
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: detailBase.toDisplayModel())
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
