//
//  MetadataPresenter.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class MetadataPresenter {
    weak var viewController: MetadataViewControllerInterface?
    var router: MetadataRouterInterface?
}

extension MetadataPresenter: MetadataPresenterInterface {
    func setLoadingView(with status: Bool) {
        perform { viewController in
            viewController.setLoadingView(with: status)
        }
    }

    func showError(with error: Error) {
        perform { viewController in
            viewController.showError(with: error)
        }
    }

    func update(with meta: MetadataBase) {
        perform { viewController in
            viewController.update(with: meta)
        }
    }
}

private extension MetadataPresenter {
    func perform(presenterAction: @escaping (MetadataViewControllerInterface) -> Void) {
        DispatchQueue.main.async { [weak viewController] in
            guard let viewController = viewController else { return }
            presenterAction(viewController)
        }
    }
}
