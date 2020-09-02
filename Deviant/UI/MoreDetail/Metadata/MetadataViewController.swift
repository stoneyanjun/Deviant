//
//  MetadataViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import DZNEmptyDataSet
import Kingfisher
import PanModal
import SwifterSwift
import UIKit

class MetadataViewController: DeviantBaseViewController {
    enum Const {
        static let avatorImageWidth: CGFloat = 32
        static let eyeImageWidth: CGFloat = 12
        static let leftMargin: CGFloat = 16
        static let topMargin: CGFloat = 16
        static let intervalVSpace: CGFloat = 12
        static let intervalHorizonSpace: CGFloat = 8
        static let eyeHorizonSpace: CGFloat = 4

        //for UICollection Layout
        static let minColumnSpace: CGFloat = 4.0
        static let minItemSpace: CGFloat = 4.0
        static let minSpace: CGFloat = 4.0
    }

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    private lazy var titleLabel = UILabel.make(color: .white,
                                               font: UIFont.headlineFont())
    private lazy var userNameLabel = UILabel.make(color: .white,
                                                  font: UIFont.headlineFont())
    private lazy var creationTimeLabel = UILabel.make(color: .lightText,
                                                      font: UIFont.footnoteFont())
    private lazy var viewsLabel = UILabel.make(color: .lightText,
                                               font: UIFont.footnoteFont())

    private lazy var avatorImageView = UIImageView(image: ImageKey.commentAvatar.image())
    private lazy var eyeImageView = UIImageView(image: ImageKey.eyeView.image())
    private lazy var containerView = UIView()
    private var metaCollectionView: UICollectionView?

    private var meta: MetadataBase?
    var interactor: MetadataInteractorInterface?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeViews()
        applyConstraints()
        interactor?.tryFetchMetadata()
    }

    deinit {
        print(#file + " " + #function)
    }
}

extension MetadataViewController: MetadataViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
    }

    func update(with meta: MetadataBase) {
        self.meta = meta
        updateUI()
        setLoadingView(with: false)
    }
}

extension MetadataViewController {
    func updateUI() {
        guard let collectionView = metaCollectionView else {
            return
        }

        titleLabel.text = meta?.metadata?.first?.title
        if let usericon = meta?.metadata?.first?.author?.usericon,
            let url = URL(string: usericon) {
            avatorImageView.kf.setImage(with: url, placeholder: ImageKey.bigLoading.image())
        } else {
            avatorImageView.image = ImageKey.commentAvatar.image()
        }
        userNameLabel.text = meta?.metadata?.first?.author?.username

        if let date = Date(deviantDateString: meta?.metadata?.first?.submission?.creationTime ?? "") {
            creationTimeLabel.text = date.formatString()
        } else {
            creationTimeLabel.text = ""
        }

        if let views = meta?.metadata?.first?.stats?.views,
            let viewToday = meta?.metadata?.first?.stats?.viewsToday {
            let viewsString = String.decimalFormat(with: NSNumber(value: views))
            let viewTodayString = String.decimalFormat(with: NSNumber(value: viewToday))
            viewsLabel.text = "\(viewsString) (\(viewTodayString) today)"
        } else {
            viewsLabel.text = ""
        }
        collectionView.reloadData()

        containerView.isHidden = false
    }
}

extension MetadataViewController {
    private func makeViews() {
        view.backgroundColor = UIColor.defaultBackground

        view.addSubview(containerView)
        containerView.isHidden = true
        containerView.addSubview(titleLabel)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(creationTimeLabel)
        containerView.addSubview(viewsLabel)
        containerView.addSubview(avatorImageView)
        containerView.addSubview(eyeImageView)

        setupCollectionView()
        customLeftBarButton()
    }

    private func applyConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Const.topMargin)
            make.leading.equalToSuperview().offset(Const.leftMargin)
            make.trailing.equalToSuperview().offset(-Const.leftMargin)
        }

        avatorImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Const.intervalVSpace)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(Const.avatorImageWidth)
            make.height.equalTo(Const.avatorImageWidth)
        }

        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatorImageView.snp.centerY)
            make.leading.equalTo(avatorImageView.snp.trailing).offset(Const.intervalVSpace)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        creationTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(avatorImageView.snp.bottom).offset(Const.intervalVSpace)
            make.bottom.equalToSuperview()
        }

        eyeImageView.snp.makeConstraints { make in
            make.leading.equalTo(creationTimeLabel.snp.trailing).offset(Const.intervalHorizonSpace * 2)
            make.centerY.equalTo(creationTimeLabel.snp.centerY)
            make.width.equalTo(Const.eyeImageWidth)
            make.height.equalTo(Const.eyeImageWidth)
        }

        viewsLabel.snp.makeConstraints { make in
            make.leading.equalTo(eyeImageView.snp.trailing).offset(Const.eyeHorizonSpace)
            make.centerY.equalTo(creationTimeLabel.snp.centerY)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        metaCollectionView?.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.leftMargin)
            make.trailing.equalToSuperview().offset(-Const.leftMargin)
            make.top.equalTo(containerView.snp.bottom).offset(Const.intervalVSpace)
            make.bottom.equalToSuperview().offset(-Const.topMargin)
        }
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        metaCollectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: layout
        )

        guard let collectionView = metaCollectionView  else {
            return
        }
        collectionView.backgroundColor = UIColor.defaultBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellType: TagCollectionViewCell.self)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: UICollectionViewCell.reuseIdentifier)
    }
}

extension MetadataViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension MetadataViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meta?.metadata?.first?.tags?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? TagCollectionViewCell,
            let tags = meta?.metadata?.first?.tags else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.reuseIdentifier,
                                                          for: indexPath)
        }
        cell.update(with: tags[indexPath.row].tagName.wrap())
        cell.setupAccessibility(row: indexPath.row)
        return cell
    }
}

extension MetadataViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchMetadata()
    }
}
