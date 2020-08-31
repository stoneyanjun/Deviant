//
//  MetadataInteractor.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import SwiftyJSON
import UIKit

class MetadataInteractor {
    var presenter: MetadataPresenterInterface?
    private(set) var config: MetadataConfiguration

    init(with configuration: MetadataConfiguration) {
        self.config = configuration
    }
}

extension MetadataInteractor: MetadataInteractorInterface {
    func tryFetchMetadata() {
        presenter?.setLoadingView(with: true)
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
        let params = MetadataParams(deviationids: [config.deviationid],
                                    extSubmission: true,
                                    extCamera: true,
                                    extStats: true,
                                    extCollection: false)
        NetworkManager<DeviantService>().networkRequest(target: .fetchMetadata(params: params)) { result in
            switch result {
            case .success(let json):
                #if DEBUG
//                print(#function + " json\r\n\(json.description)")
                #endif
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
