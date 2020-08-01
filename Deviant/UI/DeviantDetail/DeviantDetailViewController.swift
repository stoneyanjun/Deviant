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
    var interactor: DeviantDetailInteractorInterface?
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var contentImageView: UIImageView!

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
        updateUI()
    }
}

extension DeviantDetailViewController {
    func updateUI() {
        guard let detail = deviantDetail else { return }
        if let url = URL(string: (detail.content?.src ?? "")) {
            contentImageView.kf.setImage(with: url, placeholder: nil)
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
    @IBAction func infoAction(_ sender: Any) {
    }

    @IBAction func commentAction(_ sender: Any) {
    }

    @IBAction func starAction(_ sender: Any) {
    }

    @IBAction func moreAction(_ sender: Any) {
    }
}
