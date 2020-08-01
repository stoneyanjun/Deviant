//
//  TopicDetailViewController.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import Kingfisher
import Reusable
import UIKit

class TopicDetailViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
    }

    var interactor: TopicDetailInteractorInterface?
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var defaultCell = UICollectionViewCell()
    private var results: [TopicDetailResult] = []
    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customLeftBarButton()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.tryFetchTopic(with: offset)
    }
}

extension TopicDetailViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout

        let viewNib = UINib(nibName: "ImageUICollectionViewCell", bundle: nil)
        collectionView.register(viewNib, forCellWithReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier)
    }
}

extension TopicDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension TopicDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier, for: indexPath) as? ImageUICollectionViewCell,
            let src = results[indexPath.row].preview?.src,
            let url = URL(string: src) else {
            return UICollectionViewCell()
        }
        cell.image.kf.setImage(with: url, placeholder: nil)
        return cell
    }
}

extension TopicDetailViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var imageSize = CGSize()
        if let thumb = results[indexPath.row].thumbs?.first {
            imageSize.width = CGFloat(thumb.width ?? 0)
            imageSize.height = CGFloat(thumb.height ?? 0)
        }

        return imageSize
    }
}

extension TopicDetailViewController: TopicDetailViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
    }

    func update(with results: [TopicDetailResult], nextOffset: Int) {
        if self.offset <= 0 {
            self.results.removeAll()
        }
        self.results.append(contentsOf: results)
        self.offset = nextOffset
        self.collectionView.reloadData()
    }
}
