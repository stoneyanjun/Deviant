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
    private var results: [DeviantDetailBase] = []
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

        collectionView.register(ImageUICollectionViewCell.self, forCellWithReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier)
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

    private func updateCollectionView() {
        guard let collectionView = popularListCollectionView else {
            return
        }
        if results.isEmpty {
            collectionView.emptyDataSetDelegate = self
            collectionView.emptyDataSetSource = self
        }
        collectionView.reloadData()
    }
}

extension PopularListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.showDeviation(with: results[indexPath.row])
    }
}

extension PopularListViewController: UICollectionViewDataSource {
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
        cell.update(with: url)
        cell.setupAccessibility(with: .popularListCollectionCell, row: indexPath.row)
        print(#function)
        return cell
    }
}

extension PopularListViewController: CHTCollectionViewDelegateWaterfallLayout {
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

extension PopularListViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchPopular(with: offset)
    }
}
