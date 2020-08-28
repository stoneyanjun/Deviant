//
//  MoreLikeInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

protocol MoreLikeInteractorInterface {
    func tryFetchMoreLike()
}

protocol MoreLikeRouterInterface {
}

protocol MoreLikePresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with moreFromArtist: [DeviantDetailDisplayModel], moreFromDa: [DeviantDetailDisplayModel])
}

protocol MoreLikeViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with moreFromArtist: [DeviantDetailDisplayModel], moreFromDa: [DeviantDetailDisplayModel])
}
