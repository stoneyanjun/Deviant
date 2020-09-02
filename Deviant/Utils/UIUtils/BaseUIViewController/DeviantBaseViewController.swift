//
//  DeviantBaseViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import DZNEmptyDataSet
import PKHUD
import UIKit

class DeviantBaseViewController: UIViewController {
    private struct Const {
        static let baseMargin: CGFloat = 16
        static let backButtonInsets = UIEdgeInsets(top: 0,
                                                   left: -11,
                                                   bottom: 0,
                                                   right: 0)
        static let delayTime: TimeInterval = 0.5
        static let dismissHUDDelayTime: TimeInterval = 0.1
        static let errorDisplayTime: TimeInterval = 4.0
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
            HUD.hide(afterDelay: Const.dismissHUDDelayTime)
        }
    }

    func showError(errorMsg: String) {
        HUD.flash(.labeledError(title: "DeviantArt", subtitle: errorMsg), delay: Const.errorDisplayTime)
    }

    func customLeftBarButton() {
        guard let backImage = ImageKey.back.image() else { return }
        let backButton = UIBarButtonItem(image: backImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(leftBarButtonAction))
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

extension DeviantBaseViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return ImageKey.bigEmpty.image() ?? UIImage()
    }

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No date")
    }

    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        return NSAttributedString(string: "Try again")
    }
}
