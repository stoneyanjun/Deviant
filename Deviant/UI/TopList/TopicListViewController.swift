//
//  TopicListViewController.swift
//  Deviant
//
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import DZNEmptyDataSet
import ESPullToRefresh
import Kingfisher
import UIKit

class TopicListViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
        static let headerHeight: CGFloat = 50.0
    }

    private var topicListCollectionView: UICollectionView?
    var interactor: TopicListInteractorInterface?
    private lazy var defaultCell = UICollectionViewCell()
    private var results: [TopicListResult] = []
    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        setupCollectionView()
        interactor?.tryFetchTopicList(with: offset)
        setupESRefresh()
    }
}

extension TopicListViewController {
    private func setupESRefresh() {
        guard let collectionView = topicListCollectionView else {
            return
        }
        collectionView.es.addPullToRefresh {
            self.offset = 0
            self.interactor?.tryFetchTopicList(with: self.offset)
        }
        collectionView.es.addInfiniteScrolling {
            self.interactor?.tryFetchTopicList(with: self.offset)
        }
    }

    private func stopES() {
        guard let collectionView = topicListCollectionView else {
            return
        }
        collectionView.es.stopPullToRefresh()
        collectionView.es.stopLoadingMore()
    }

    private func updateCollectionView() {
        guard let collectionView = topicListCollectionView else {
            return
        }
        if results.isEmpty {
            collectionView.emptyDataSetDelegate = self
            collectionView.emptyDataSetSource = self
        }
        collectionView.reloadData()
    }
}

extension TopicListViewController {
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace
        topicListCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: layout
        )
        guard let collectionView = topicListCollectionView else {
            return
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true

        collectionView.register(ImageUICollectionViewCell.self, forCellWithReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier)
        collectionView.register(TopicListHeadView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TopicListHeadView.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
}

extension TopicListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let topicListDeviation = results[indexPath.section].deviations?[indexPath.row] else {
            return
        }
        self.interactor?.showDeviation(with: topicListDeviation)
    }
}

extension TopicListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results[section].deviations?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            ImageUICollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? ImageUICollectionViewCell,
            let src = results[indexPath.section].deviations?[indexPath.row].preview?.src ,
            let url = URL(string: src) else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        }
        cell.imageView.kf.setImage(with: url, placeholder: UIImage(named: "loading"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        heightForHeaderIn section: Int) -> CGFloat {
        return Const.headerHeight
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let head = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                          withReuseIdentifier: TopicListHeadView.reuseIdentifier,
                                                                          for: indexPath) as? TopicListHeadView {
                let record = results[indexPath.section]
                head.update(with: record.name.wrap()) {
                    self.interactor?.showTopic(with: record.name.wrap())
                }
                return head
            }
            return UICollectionReusableView()
        } else {
            return UICollectionReusableView()
        }
    }
}

extension TopicListViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var imageSize = CGSize()
        if let thumb = results[indexPath.section].deviations?[indexPath.row].thumbs?.first {
            imageSize.width = CGFloat(thumb.width ?? 0)
            imageSize.height = CGFloat(thumb.height ?? 0)
        }

        return imageSize
    }
}

extension TopicListViewController: TopicListViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }

    func showError(with error: Error) {
        stopES()
        showError(errorMsg: error.localizedDescription)
        updateCollectionView()
    }

    func update(with results: [TopicListResult], nextOffset: Int) {
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

extension TopicListViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchTopicList(with: offset)
    }
}
