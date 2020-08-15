//
//  MetadataViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import DZNEmptyDataSet
import Kingfisher
import PanModal
import Reusable
import SwifterSwift
import UIKit

class MetadataViewController: DeviantBaseViewController {

    enum Const {
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

    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var creationTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    private var meta: MetadataBase?
    var interactor: MetadataInteractorInterface?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        customLeftBarButton()
        interactor?.tryFetchMetadata()
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
        setLoadingView(with: false)
        self.meta = meta
        updateUI()
    }
}

extension MetadataViewController {
    func updateUI() {
        titleLabel.text = meta?.metadata?.first?.title
        if let usericon = meta?.metadata?.first?.author?.usericon,
            let url = URL(string: usericon) {
            avatorImageView.kf.setImage(with: url, placeholder: UIImage(named: "loading"))
        } else {
            avatorImageView.image = UIImage(named: "AvatorWhite")
        }
        userNameLabel.text = meta?.metadata?.first?.author?.username
        collectionView.reloadData()

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
    }
}

extension MetadataViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.setCollectionViewLayout(flowLayout, animated: false)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let viewNib = UINib(nibName: "TagCollectionViewCell", bundle: nil)
        collectionView.register(viewNib, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as? TagCollectionViewCell,
            let tags = meta?.metadata?.first?.tags else {
                return UICollectionViewCell()
        }
        cell.tagLabel.text = tags[indexPath.row].tagName
        return cell
    }
}

extension MetadataViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchMetadata()
    }
}
