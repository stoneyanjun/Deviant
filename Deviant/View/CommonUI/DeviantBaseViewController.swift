//
//  DeviantBaseViewController.swift
//  Deviant
//
//  Created by stone on 2020/7/4.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit
import PKHUD

class DeviantBaseViewController: UIViewController {
    func setLoadingWith(status: Bool, message: String) {
        if status {
            HUD.show(.progress)
        } else {
            HUD.hide()
        }
    }
}
