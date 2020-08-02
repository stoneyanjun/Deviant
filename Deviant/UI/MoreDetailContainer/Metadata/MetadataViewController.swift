//
//  MetadataViewController.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import Kingfisher
import PanModal
import Reusable
import UIKit

class MetadataViewController: DeviantBaseViewController {
    var interactor: MetadataInteractorInterface?

    enum Const {
        static let minColumnSpace: CGFloat = 4.0
        static let minItemSpace: CGFloat = 4.0
        static let minSpace: CGFloat = 4.0
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var meta: MetadataBase?
//    private var deviantDetail: MetadataBase?
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        customLeftBarButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        self.meta = meta
        updateUI()
    }
}

extension MetadataViewController {
    func updateUI() {
        titleLabel.text = meta?.metadata?.first?.title
        if let usericon = meta?.metadata?.first?.author?.usericon,
            let url = URL(string: usericon) {
            avatorImageView.kf.setImage(with: url)
        } else {
            avatorImageView.image = UIImage(named: "AvatorWhite")
        }
        userNameLabel.text = meta?.metadata?.first?.author?.username
        collectionView.reloadData()
    }
}

extension MetadataViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace

        collectionView.autoresizingMask = [.flexibleWidth]
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout

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
        print(tags[indexPath.row].tagName)
        return cell
    }
}

extension MetadataViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*
        var imageSize = CGSize()
        if let thumb = results[indexPath.row].thumbs?.first {
            imageSize.width = CGFloat(thumb.width ?? 0)
            imageSize.height = CGFloat(thumb.height ?? 0)
        }
 */

        return CGSize(width: 50, height: 36)
    }
}
