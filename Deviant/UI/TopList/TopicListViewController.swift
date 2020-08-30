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
    private var displayModels: [TopicListDisplay] = []
    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        setupCollectionView()
        interactor?.tryFetchTopicList(with: offset)
        setupESRefresh()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function + " TopicListViewController")
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

        collectionView.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.reuseIdentifier)
        collectionView.register(TopicListHeadView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TopicListHeadView.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }

    private func updateCollectionView() {
        guard let collectionView = topicListCollectionView else {
            return
        }
        if displayModels.isEmpty {
            collectionView.emptyDataSetDelegate = self
            collectionView.emptyDataSetSource = self
        }
        collectionView.reloadData()
    }

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
}

extension TopicListViewController {
}

extension TopicListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let displayModel = displayModels[indexPath.section].deviantDetails?[indexPath.row] else {
            return
        }

        interactor?.showDeviation(with: displayModel)
    }
}

extension TopicListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return displayModels.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayModels[section].deviantDetails?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayModel = displayModels[indexPath.section].deviantDetails?[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? CommonCollectionViewCell,
            let src = displayModel?.src,
            let url = URL(string: src) else {
                return UICollectionViewCell()
        }
        let viewDate = CommonCollectionViewCell.ViewData(url: url,
                                                          title: displayModel?.title,
                                                          username: displayModel?.username,
                                                          identifier: .topicListCollectionCell,
                                                          row: indexPath.row)
        cell.update(with: viewDate)
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
                let topicName = displayModels[indexPath.section].name
                let viewData = TopicListHeadView.ViewData(title: topicName,
                                                          row: indexPath.section,
                                                          identifier: .topicListHeadView) {
                                                            self.interactor?.showTopic(with: topicName)
                }
                head.update(with: viewData)
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
        let displayModel = displayModels[indexPath.section].deviantDetails?[indexPath.row]
        return CGSize(width: displayModel?.width ?? 0,
                      height: displayModel?.height ?? 0)
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

    func update(with displayModels: [TopicListDisplay], nextOffset: Int) {
        stopES()
        if self.offset <= 0 {
            self.displayModels.removeAll()
        }
        self.displayModels.append(contentsOf: displayModels)
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
