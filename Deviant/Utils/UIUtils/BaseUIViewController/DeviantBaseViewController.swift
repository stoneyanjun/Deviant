//
//  DeviantBaseViewController.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import PKHUD
import UIKit

class DeviantBaseViewController: UIViewController {
    private struct Const {
        static let baseMargin: CGFloat = 16
        static let backButtonInsets = UIEdgeInsets(top: 0, left: -11, bottom: 0, right: 0)
        static let delayTime: TimeInterval = 0.5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DeviantBaseViewController {
    func setHUD(with status: Bool) {
        if status {
            HUD.show(.progress)
        } else {
            HUD.hide()
        }
    }

    func showError(errorMsg: String) {
        HUD.flash(.labeledError(title: "DeviantArt", subtitle: errorMsg), delay: 3.0)
    }

    func customLeftBarButton() {
        guard let backImage = UIImage(named: "back") else { return }
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(leftBarButtonAction))
        backButton.tintColor = .black
        backButton.imageInsets = Const.backButtonInsets
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }

    @objc
    func leftBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
