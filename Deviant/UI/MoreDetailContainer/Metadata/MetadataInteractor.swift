//
//  MetadataInteractor.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class MetadataInteractor {
    var presenter: MetadataPresenterInterface?
    private(set) var config: MetadataConfiguration

    init(config: MetadataConfiguration) {
        self.config = config
    }
}

extension MetadataInteractor: MetadataInteractorInterface {
    func tryFetchMetadata() {
        if TokenManager.shared.needFetchToken() {
            TokenManager.shared.fetchToken { result in
                switch result {
                case .success:
                    self.fetchMetadata()
                case .failure(let error):
                    self.presenter?.showError(with: error)
                }
            }
        } else {
            self.fetchMetadata()
        }
    }
}

extension MetadataInteractor {
    private func fetchMetadata() {
        guard let deviationid = config.deviantDetail?.deviationid,
            !deviationid.isEmpty else {
            return
        }
        let params = MetadataParams(deviationids: [deviationid], extSubmission: false, extCamera: false, extStats: false, extCollection: false)
        NetworkManager<DeviantService>().networkRequest(target: .fetchMetadata(params: params)) { result in
            switch result {
            case .success(let json):
                print(#function + "\r\n\(json.description)")
                guard let metadataBase = JSONDeserializer<MetadataBase>.deserializeFrom(json: json.description)
                    else {
                        self.presenter?.showError(with: DeviantGeneralError.unknownError)
                        return
                }
                self.presenter?.update(with: metadataBase)
            case .failure(let error):
                self.presenter?.showError(with: error)
            }
        }
    }
}
