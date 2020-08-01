//
//  DeviantDetailViewController.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import Kingfisher
import Reusable
import UIKit

class DeviantDetailViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
    }

    var interactor: DeviantDetailInteractorInterface?

    private var deviantDetail: DeviantDetailBase?
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customLeftBarButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.tryFetchDeviantDetail()
    }
}

extension DeviantDetailViewController: DeviantDetailViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
    }

    func update(with deviantDetail: DeviantDetailBase) {
        self.deviantDetail = deviantDetail
    }
}
