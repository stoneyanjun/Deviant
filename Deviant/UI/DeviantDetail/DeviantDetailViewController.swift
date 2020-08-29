//
//  DeviantDetailViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import PanModal
import Reusable
import SnapKit
import UIKit

class DeviantDetailViewController: DeviantBaseViewController {
    enum Const {
        static let leftMargin: CGFloat = 16
        static let topMargin: CGFloat = 16
        static let bottomMargin: CGFloat = 32
        static let intervalVSpace: CGFloat = 12
    }

    private lazy var infoButton = UIButton()
    private lazy var commentButton = UIButton()
    private lazy var starsButton = UIButton()
    private lazy var moreLikeButton = UIButton()
    private lazy var contentImageView = UIImageView()

    var interactor: DeviantDetailInteractorInterface?
    private var deviantDetail: DeviantDetailDisplayModel?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeViews()
        applyConstraints()
        customLeftBarButton()
        interactor?.tryFetchDeviantDetail()
    }
}

extension DeviantDetailViewController {
    private func makeViews() {
        view.backgroundColor = UIColor.defaultBackground
        infoButton.setImageForAllStates(UIImage(named: "bigInfo") ?? UIImage())
        infoButton.tag = 0
        infoButton.addTarget(self, action: #selector(infoAction(_:)), for: .touchUpInside)
        view.addSubview(infoButton)

        commentButton.setImageForAllStates(UIImage(named: "bigCommentWhite") ?? UIImage())
        commentButton.tag = 1
        commentButton.addTarget(self, action: #selector(infoAction(_:)), for: .touchUpInside)
        view.addSubview(commentButton)

        starsButton.setImageForAllStates(UIImage(named: "bigStarWhite") ?? UIImage())
        starsButton.tag = 2
        starsButton.addTarget(self, action: #selector(infoAction(_:)), for: .touchUpInside)
        view.addSubview(starsButton)

        moreLikeButton.setImageForAllStates(UIImage(named: "bigMore") ?? UIImage())
        moreLikeButton.tag = 3
        moreLikeButton.addTarget(self, action: #selector(infoAction(_:)), for: .touchUpInside)
        view.addSubview(moreLikeButton)

        contentImageView.contentMode = .scaleAspectFit
        view.addSubview(contentImageView)

        setupAccessibility()
    }

    private func applyConstraints() {
        contentImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Const.topMargin)
            make.leading.equalToSuperview().offset(Const.leftMargin)
            make.trailing.equalToSuperview().offset(-Const.leftMargin)
        }

        infoButton.snp.makeConstraints { make in
            make.top.equalTo(contentImageView.snp.bottom).offset(Const.topMargin)
            make.leading.equalTo(contentImageView.snp.leading)
            make.bottom.equalToSuperview().offset(-Const.bottomMargin)
            make.width.equalTo(commentButton.snp.width)
        }

        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(infoButton.snp.centerY)
            make.leading.equalTo(infoButton.snp.trailing).offset(Const.intervalVSpace)
            make.width.equalTo(starsButton.snp.width)
        }

        starsButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentButton.snp.centerY)
            make.leading.equalTo(commentButton.snp.trailing).offset(Const.intervalVSpace)
            make.width.equalTo(moreLikeButton.snp.width)
        }

        moreLikeButton.snp.makeConstraints { make in
            make.centerY.equalTo(starsButton.snp.centerY)
            make.leading.equalTo(starsButton.snp.trailing).offset(Const.intervalVSpace)
            make.trailing.equalTo(contentImageView.snp.trailing)
        }
    }
}

extension DeviantDetailViewController: DeviantDetailViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
    }

    func update(with deviantDetail: DeviantDetailDisplayModel) {
        self.deviantDetail = deviantDetail
        updateUI()
        setLoadingView(with: false)
    }
}

extension DeviantDetailViewController {
    @objc
    func infoAction(_ sender: UIButton) {
        guard let deviantDetail = self.deviantDetail else {
            return
        }
        interactor?.showMoreDetail(with: deviantDetail, tag: sender.tag)
    }

    func updateUI() {
        guard let detail = deviantDetail else { return }
        if let url = URL(string: (detail.src ?? "")) {
            contentImageView.kf.setImage(with: url,
                                         placeholder: UIImage(named: "bigLoading"))
        } else {
            contentImageView.image = UIImage(named: "bigEmpty")
        }

        if let comments = detail.comments, comments > 0 {
            commentButton.setTitle(" \(comments)", for: .normal)
        }
        if let favourites = detail.favourites, favourites > 0 {
            starsButton.setTitle(" \(favourites)", for: .normal)
        }
    }

    private func setupAccessibility() {
        infoButton.accessibilityIdentifier = AccessibilityIdentifier.moreInfoButton.accessibilityIdentifier()
        commentButton.accessibilityIdentifier = AccessibilityIdentifier.commentButton.accessibilityIdentifier()
        starsButton.accessibilityIdentifier = AccessibilityIdentifier.favorateButton.accessibilityIdentifier()
        moreLikeButton.accessibilityIdentifier = AccessibilityIdentifier.moreLikeButton.accessibilityIdentifier()
    }
}
