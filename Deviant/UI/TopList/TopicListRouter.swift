//
//  TopicListRouter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class TopicListRouter: NSObject {
    var navigationController: UINavigationController?
    weak var viewController: TopicListViewControllerInterface?
}

extension TopicListRouter: TopicListRouterInterface {
    func showDeviation(with deviantDetail: DeviantDetailDisplayModel) {
        guard let navi = navigationController else { return }
        let detailParams = DeviantDetailParams(deviationid: deviantDetail.deviationid ,
                                               username: deviantDetail.username ,
                                               title: deviantDetail.title)
        let config = DeviantDetailConfiguration(navigationController: navi, detailParams: detailParams)
        let deviantDetailVC = DeviantDetailConfigurator(config: config).createViewController()
        navi.pushViewController(deviantDetailVC, animated: true)
    }

    func showTopic(with topicName: String) {
        guard let navi = navigationController else { return }
        let config = CommonListConfiguration(navigationController: navi, listType: .topicDetail(topicName))
        let topicDetailVC = CommonListConfigurator(config: config).createViewController()
        navi.pushViewController(topicDetailVC, animated: true)
    }
}
