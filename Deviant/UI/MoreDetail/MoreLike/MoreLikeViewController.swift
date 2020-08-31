//
//  MoreLikeViewController.swift
//  Deviant
//
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import DZNEmptyDataSet
import Kingfisher
import SnapKit
import UIKit

class MoreLikeViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
        static let headerHeight: CGFloat = 50.0
    }

    var interactor: MoreLikeInteractorInterface?
    private lazy var defaultCell = UICollectionViewCell()
    private var moreLikeCollectionView: UICollectionView?
    private var moreFromArtist: [DeviantDetailDisplayModel] = []
    private var moreFromDa: [DeviantDetailDisplayModel] = []
    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        setupCollectionView()
        interactor?.tryFetchMoreLike()
    }

    deinit {
        print(#file + " " + #function)
    }
}

extension MoreLikeViewController {
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace

        moreLikeCollectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: layout
        )
        guard let collectionView = moreLikeCollectionView else {
            return
        }
        collectionView.backgroundColor = UIColor.defaultBackground
        view.addSubview(collectionView)
        collectionView.frame = view.frame
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
        collectionView.register(TopicListHeadView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TopicListHeadView.reuseIdentifier)

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }

    private func updateCollectionView() {
        guard let collectionView = moreLikeCollectionView else {
            return
        }

        if moreFromArtist.isEmpty && moreFromDa.isEmpty {
            collectionView.emptyDataSetDelegate = self
            collectionView.emptyDataSetSource = self
        }
        collectionView.reloadData()
    }
}

extension MoreLikeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension MoreLikeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? moreFromArtist.count : moreFromDa.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayModel = getDisplayModel(with: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? CommonCollectionViewCell,
            let src = displayModel.previewImage?.src,
            let url = URL(string: src) else {
                return UICollectionViewCell()
        }
        let viewDate = CommonCollectionViewCell.ViewData(url: url,
                                                         title: displayModel.title,
                                                         username: displayModel.username,
                                                         identifier: .moreLikeCollectionCell,
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
        if kind != UICollectionView.elementKindSectionHeader {
            return UICollectionReusableView()
        }

        guard let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: TopicListHeadView.reuseIdentifier,
                                                                             for: indexPath) as? TopicListHeadView else {
                                                                                return UICollectionReusableView()
        }
        let title = (indexPath.section == 0) ? "MORE BY THIS ARTIST" : "MORE LIKE THIS"
        let viewData = TopicListHeadView.ViewData(title: title,
                                                  row: indexPath.section,
                                                  identifier: .moreLikeHeadView)
        headView.update(with: viewData)
        return headView
    }
}

extension MoreLikeViewController {
    private func getDisplayModel(with indexPath: IndexPath) -> DeviantDetailDisplayModel {
        return (indexPath.section == 0) ? moreFromArtist[indexPath.row] : moreFromDa[indexPath.row]
    }

    private func getImageSize(indexPath: IndexPath) -> CGSize {
        let displayModel = getDisplayModel(with: indexPath)
        return CGSize(width: displayModel.previewImage?.width ?? 0,
                      height: displayModel.previewImage?.height ?? 0)
    }
}

extension MoreLikeViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getImageSize(indexPath: indexPath)
    }
}

extension MoreLikeViewController: MoreLikeViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
        updateCollectionView()
    }

    func update(with moreFromArtist: [DeviantDetailDisplayModel], moreFromDa: [DeviantDetailDisplayModel]) {
        self.moreFromArtist = moreFromArtist
        self.moreFromDa = moreFromDa
        updateCollectionView()
        setLoadingView(with: false)
    }
}

extension MoreLikeViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchMoreLike()
    }
}
