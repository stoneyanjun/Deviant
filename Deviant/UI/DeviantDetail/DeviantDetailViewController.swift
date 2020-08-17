//
//  DeviantDetailViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import PanModal
import Reusable
import UIKit

class DeviantDetailViewController: DeviantBaseViewController {
    var interactor: DeviantDetailInteractorInterface?
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var contentImageView: UIImageView!

    private var deviantDetail: DeviantDetailBase?
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customLeftBarButton()
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
        updateUI()
        setLoadingView(with: false)
    }
}

extension DeviantDetailViewController {
    func updateUI() {
        guard let detail = deviantDetail else { return }
        if let url = URL(string: (detail.content?.src ?? "")) {
            contentImageView.kf.setImage(with: url,
                                         placeholder: UIImage(named: "loading"))
        }

        if let comments = detail.stats?.comments, comments > 0 {
            commentButton.setTitle(" \(comments)", for: .normal)
        }
        if let favourites = detail.stats?.favourites, favourites > 0 {
            starButton.setTitle(" \(favourites)", for: .normal)
        }
    }
}

extension DeviantDetailViewController {
    @IBAction func infoAction(_ sender: UIButton) {
        guard let deviantDetail = self.deviantDetail else {
                return
        }
        let moreDetailContainerVC = MoreDetailContainerVC()
        moreDetailContainerVC.deviantDetail = deviantDetail
        moreDetailContainerVC.focusIndex = sender.tag
        presentPanModal(moreDetailContainerVC)
    }
}
