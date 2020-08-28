//
//  PopularListViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import DZNEmptyDataSet
import ESPullToRefresh
import Kingfisher
import Reusable
import SnapKit
import UIKit

class PopularListViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
    }

    var interactor: PopularListInteractorInterface?
    private var popularListCollectionView: UICollectionView?
    private lazy var defaultCell = UICollectionViewCell()
    private var displayModels: [DeviantDetailDisplayModel] = []
    private var offset = 0
    private var errorDesc: String?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        setupCollectionView()
        interactor?.tryFetchPopular(with: offset)
        setupESRefresh()
    }
}

extension PopularListViewController {
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace
        popularListCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: layout
        )
        guard let collectionView = popularListCollectionView else {
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
        collectionView.collectionViewLayout = layout

        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
    }

    private func updateCollectionView() {
        guard let collectionView = popularListCollectionView else {
            return
        }
        if displayModels.isEmpty {
            collectionView.emptyDataSetDelegate = self
            collectionView.emptyDataSetSource = self
        }
        collectionView.reloadData()
    }
    
    private func setupESRefresh() {
        guard let collectionView = popularListCollectionView else {
            return
        }
        collectionView.es.addPullToRefresh {
            self.offset = 0
            self.errorDesc = nil
            self.interactor?.tryFetchPopular(with: self.offset)
        }
        collectionView.es.addInfiniteScrolling {
            self.errorDesc = nil
            self.interactor?.tryFetchPopular(with: self.offset)
        }
    }

    private func stopES() {
        guard let collectionView = popularListCollectionView else {
            return
        }
        collectionView.es.stopPullToRefresh()
        collectionView.es.stopLoadingMore()
    }
}

extension PopularListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.showDeviation(with: displayModels[indexPath.row])
    }
}

extension PopularListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayModel = displayModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? ImageCollectionViewCell,
            let src = displayModel.src,
            let url = URL(string: src) else {
            return UICollectionViewCell()
        }
        let viewDate = ImageCollectionViewCell.ViewData(url: url,
                                                          title: displayModel.title,
                                                          username: displayModel.username,
                                                          identifier: .popularListCollectionCell,
                                                          row: indexPath.row)
        cell.update(with: viewDate)
        return cell
    }
}

extension PopularListViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let displayModel = displayModels[indexPath.row]
        return CGSize(width: displayModel.width ?? 0,
                      height: displayModel.height ?? 0)
    }
}

extension PopularListViewController: PopularListViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }

    func showError(with error: Error) {
        stopES()
        self.errorDesc = error.localizedDescription
        showError(errorMsg: error.localizedDescription)
        updateCollectionView()
    }
    func update(with displayModels: [DeviantDetailDisplayModel], nextOffset: Int) {
//    func update(with displayModels: [DeviantDetailBase], nextOffset: Int) {
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

extension PopularListViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchPopular(with: offset)
    }
}
