//
//  TopicDetailViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import DZNEmptyDataSet
import ESPullToRefresh
import Kingfisher
import Reusable
import UIKit

class TopicDetailViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
    }

    private var topicDetailCollectionView: UICollectionView?
    var interactor: TopicDetailInteractorInterface?
    private lazy var defaultCell = UICollectionViewCell()
    private var results: [DeviantDetailBase] = []
    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        customLeftBarButton()
        setupCollectionView()
        interactor?.tryFetchTopic(with: offset)
        setupPullToRefresh()
    }
}

extension TopicDetailViewController {
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace
        topicDetailCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: layout
        )
        guard let collectionView = topicDetailCollectionView else {
            return
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true

        let viewNib = UINib(nibName: "ImageUICollectionViewCell", bundle: nil)
        collectionView.register(viewNib, forCellWithReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier)
    }

    private func setupPullToRefresh() {
        guard let collectionView = topicDetailCollectionView else {
            return
        }
        collectionView.es.addPullToRefresh {
            self.offset = 0
            self.interactor?.tryFetchTopic(with: self.offset)
        }
        collectionView.es.addInfiniteScrolling {
            self.interactor?.tryFetchTopic(with: self.offset)
        }
    }

    private func stopES() {
        guard let collectionView = topicDetailCollectionView else {
            return
        }
        collectionView.es.stopPullToRefresh()
        collectionView.es.stopLoadingMore()
    }

    private func updateCollectionView() {
        guard let collectionView = topicDetailCollectionView else {
            return
        }
        if results.isEmpty {
            collectionView.emptyDataSetDelegate = self
            collectionView.emptyDataSetSource = self
        }
        collectionView.reloadData()
    }
}

extension TopicDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.interactor?.showDeviation(with: results[indexPath.row])
    }
}

extension TopicDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? ImageUICollectionViewCell,
            let src = results[indexPath.row].preview?.src,
            let url = URL(string: src) else {
                return UICollectionViewCell()
        }
        cell.image.kf.setImage(with: url, placeholder: UIImage(named: "loading"))
        return cell
    }
}

extension TopicDetailViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        stopES()
        updateCollectionView()
        showError(errorMsg: error.localizedDescription)
    }

    func update(with results: [DeviantDetailBase], nextOffset: Int) {
        stopES()
        if self.offset <= 0 {
            self.results.removeAll()
        }
        self.results.append(contentsOf: results)
        self.offset = nextOffset
        updateCollectionView()
        setLoadingView(with: false)
    }
}

extension TopicDetailViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchTopic(with: offset)
    }
}
