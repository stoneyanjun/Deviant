//
//  MetadataInterface.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

protocol MetadataInteractorInterface {
    func tryFetchMetadata()
}

protocol MetadataRouterInterface {
}

protocol MetadataPresenterInterface {
    func setLoadingView(with status: Bool)
    func showError(with error: Error)
    func update(with meta: MetadataBase)
}

protocol MetadataViewControllerInterface: UIViewController {
    func showError(with error: Error)
    func setLoadingView(with status: Bool)
    func update(with meta: MetadataBase)
}
