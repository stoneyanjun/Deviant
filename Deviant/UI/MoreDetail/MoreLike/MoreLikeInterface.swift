//
//  MoreLikeInterface.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
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
    func update(with moreFromArtist: [DeviantDetailBase], moreFromDa: [DeviantDetailBase])
}

protocol MoreLikeViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with moreFromArtist: [DeviantDetailBase], moreFromDa: [DeviantDetailBase])
}
