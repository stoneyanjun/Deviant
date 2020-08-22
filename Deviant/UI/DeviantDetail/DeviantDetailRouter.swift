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
    func showMoreDetail(with deviantDetail: DeviantDetailBase, tag: Int) {
        let moreDetailContainerVC = MoreDetailContainerVC()
        moreDetailContainerVC.deviantDetail = deviantDetail
        moreDetailContainerVC.focusIndex = tag
        viewController?.presentPanModal(moreDetailContainerVC)
    }
}
