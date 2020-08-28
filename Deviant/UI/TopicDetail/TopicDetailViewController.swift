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
        static let margin: CGFloat = 16
    }

    private var topicDetailCollectionView: UICollectionView?
    var interactor: TopicDetailInteractorInterface?
    private lazy var defaultCell = UICollectionViewCell()
    private var results: [DeviantDetailDisplayModel] = []
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
            make.top.equalToSuperview().offset(Const.margin)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true

        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
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

    private func setupPullToRefresh() {
        guard let collectionView = topicDetailCollectionView else {
            return
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
        let displayModel = results[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? ImageCollectionViewCell,
            let src = displayModel.src,
            let url = URL(string: src) else {
                return UICollectionViewCell()
        }
        let viewDate = ImageCollectionViewCell.ViewData(url: url,
                                                          title: displayModel.title,
                                                          username: displayModel.username,
                                                          identifier: .topicDetailCollectionCell,
                                                          row: indexPath.row)
        cell.update(with: viewDate)
        return cell
    }
}

extension TopicDetailViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let displayModel = results[indexPath.row]
        return CGSize(width: displayModel.width ?? 0,
                      height: displayModel.height ?? 0)
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

    func update(with results: [DeviantDetailDisplayModel], nextOffset: Int) {
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
