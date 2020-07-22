//
//  DeviantBaseViewController.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit
import PKHUD

class DeviantBaseViewController: UIViewController {
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
}
