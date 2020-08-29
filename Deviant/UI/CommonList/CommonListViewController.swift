//
//  CommonListViewController.swift
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

class CommonListViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
    }

    var interactor: CommonListInteractorInterface?
    private var listType: ListType?
    private var listCollectionView: UICollectionView?
    private lazy var defaultCell = UICollectionViewCell()
    private var displayModels: [DeviantDetailDisplayModel] = []
    private var offset = 0
    private var errorDesc: String?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        setupCollectionView()
        interactor?.tryFetchList(with: offset)
        setupESRefresh()
        setupTitle()
        customLeftBarButton()
    }

    func setListType(with listType: ListType) {
        self.listType = listType
    }

    private func setupTitle() {
        switch listType {
        case .topicDetail(let topicName) :
            self.title = topicName
        default:
            break
        }
    }
}

extension CommonListViewController {
    private func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace
        listCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: layout
        )
        guard let collectionView = listCollectionView else {
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

        collectionView.register(CommonCollectionViewCell.self,
                                forCellWithReuseIdentifier: CommonCollectionViewCell.reuseIdentifier)
    }

    private func updateCollectionView() {
        guard let collectionView = listCollectionView else {
            return
        }
        if displayModels.isEmpty {
            collectionView.emptyDataSetDelegate = self
            collectionView.emptyDataSetSource = self
        }
        collectionView.reloadData()
    }
}

extension CommonListViewController {
    private func setupESRefresh() {
        guard let collectionView = listCollectionView else {
            return
        }
        switch listType {
        case .popularList:
            collectionView.es.addPullToRefresh {
                self.offset = 0
                self.errorDesc = nil
                self.interactor?.tryFetchList(with: self.offset)
            }
        default:
            break
        }

        collectionView.es.addInfiniteScrolling {
            self.errorDesc = nil
            self.interactor?.tryFetchList(with: self.offset)
        }
    }

    private func stopES() {
        guard let collectionView = listCollectionView else {
            return
        }
        collectionView.es.stopPullToRefresh()
        collectionView.es.stopLoadingMore()
    }
}

extension CommonListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.showDeviation(with: displayModels[indexPath.row])
    }
}

extension CommonListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayModel = displayModels[indexPath.row]
        let  reuseIdentifier = CommonCollectionViewCell.reuseIdentifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? CommonCollectionViewCell,
            let src = displayModel.src,
            let url = URL(string: src) else {
            return UICollectionViewCell()
        }

        var cellIdentifier: AccessibilityIdentifier = .commonListCollectionCell
        switch listType {
        case .popularList:
            cellIdentifier = .popularListCollectionCell
        case .topicDetail :
            cellIdentifier = .topicDetailCollectionCell
        default:
            break
        }

        let viewDate = CommonCollectionViewCell.ViewData(url: url,
                                                         title: displayModel.title,
                                                         username: displayModel.username,
                                                         identifier: cellIdentifier,
                                                         row: indexPath.row)
        cell.update(with: viewDate)
        return cell
    }
}

extension CommonListViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let displayModel = displayModels[indexPath.row]
        return CGSize(width: displayModel.width ?? 0,
                      height: displayModel.height ?? 0)
    }
}

extension CommonListViewController: CommonListViewControllerInterface {
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

extension CommonListViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchList(with: offset)
    }
}
