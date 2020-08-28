//
//  DeviantDetailRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class DeviantDetailRouter: NSObject {
    weak var viewController: DeviantDetailViewControllerInterface?
}

extension DeviantDetailRouter: DeviantDetailRouterInterface {
    func showMoreDetail(with deviantDetail: DeviantDetailDisplayModel, tag: Int) {
        guard !deviantDetail.deviationid.isEmpty else {
            return
        }
        let moreDetailContainerVC = MoreDetailContainerVC()
        moreDetailContainerVC.deviationid = deviantDetail.deviationid
        moreDetailContainerVC.focusIndex = tag
        viewController?.presentPanModal(moreDetailContainerVC)
    }
}
