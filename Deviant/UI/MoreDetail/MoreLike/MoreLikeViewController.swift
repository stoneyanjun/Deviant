//
//  MoreLikeViewController.swift
//  Deviant
//
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import DZNEmptyDataSet
import Kingfisher
import UIKit

class MoreLikeViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
        static let headerHeight: CGFloat = 50.0
    }

    var interactor: MoreLikeInteractorInterface?
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var defaultCell = UICollectionViewCell()

    private var moreFromArtist: [DeviantDetailBase] = []
    private var moreFromDa: [DeviantDetailBase] = []

    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        interactor?.tryFetchMoreLike()
    }
}

extension MoreLikeViewController {
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
        let headNib = UINib(nibName: "TopicListHeadView", bundle: nil)
        collectionView.register(headNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TopicListHeadView.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }

    private func updateCollectionView() {
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
            cell.image.kf.setImage(with: url, placeholder: UIImage(named: "loading"))
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
                if indexPath.section == 0 {
                    headView.topicLabel.text = "MORE BY THIS ARTIST"
                } else {
                    headView.topicLabel.text = "MORE LIKE THIS"
                }
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
        setLoadingView(with: false)
        self.moreFromArtist = moreFromArtist
        self.moreFromDa = moreFromDa
        updateCollectionView()
    }
}

extension MoreLikeViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchMoreLike()
    }
}
