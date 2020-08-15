//
//  MetadataInterface.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
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
