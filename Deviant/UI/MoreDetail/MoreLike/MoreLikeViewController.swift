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
    private var moreFromArtist: [DeviantDetailBase] = []
    private var moreFromDa: [DeviantDetailBase] = []
    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        setupCollectionView()
        interactor?.tryFetchMoreLike()
    }
}

extension MoreLikeViewController {
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = Const.minColumnSpace
        layout.minimumInteritemSpacing = Const.minItemSpace

        moreLikeCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: layout
        )
        guard let collectionView = moreLikeCollectionView else {
            return
        }
        collectionView.backgroundColor = UIColor.defaultBackground
        view.addSubview(collectionView)
        collectionView.frame = self.view.frame
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout
        
        collectionView.register(ImageUICollectionViewCell.self, forCellWithReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier)
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
        if section == 0 {
            return moreFromArtist.count
        } else {
            return moreFromDa.count
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? ImageUICollectionViewCell else {
               return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        }
        if let url = getURL(indexPath: indexPath) {
            cell.update(with: url)
            cell.setupAccessibility(with: .moreLikeCollectionCell, row: indexPath.row)
        }
        return cell
    }

    func getURL(indexPath: IndexPath) -> URL? {
        var urlString = ""
        if indexPath.section == 0 {
            if let src = moreFromArtist[indexPath.row].preview?.src {
                urlString = src
            } else {
                urlString = moreFromArtist[indexPath.row].url ?? ""
            }
        } else {
            if let src = moreFromDa[indexPath.row].preview?.src {
                urlString = src
            } else {
                urlString = moreFromDa[indexPath.row].url ?? ""
            }
        }
        return URL(string: urlString)
    }

    func getImageSize(indexPath: IndexPath) -> CGSize {
        var size = CGSize()
        if indexPath.section == 0 {
            if let preview = moreFromArtist[indexPath.row].preview {
                size.width = CGFloat(preview.width ?? 0)
                size.height = CGFloat(preview.height ?? 0)
            }
        } else {
            if let preview = moreFromDa[indexPath.row].preview {
                size.width = CGFloat(preview.width ?? 0)
                size.height = CGFloat(preview.height ?? 0)
            }
        }

        return size
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        heightForHeaderIn section: Int) -> CGFloat {
        return Const.headerHeight
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                              withReuseIdentifier: TopicListHeadView.reuseIdentifier,
                                                                              for: indexPath) as? TopicListHeadView {
                let title = (indexPath.section == 0) ? "MORE BY THIS ARTIST"
                    : "MORE LIKE THIS"
                let viewData = TopicListHeadView.ViewData(title: title,
                                                          row: indexPath.section,
                                                          identifier: .moreLikeHeadView)
                headView.update(with: viewData)
                return headView
            }

            return UICollectionReusableView()
        } else {
            return UICollectionReusableView()
        }
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

    func update(with moreFromArtist: [DeviantDetailBase], moreFromDa: [DeviantDetailBase]) {
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
