//
//  TopicListViewController.swift
//  Deviant
//
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import Kingfisher
import UIKit

class TopicListViewController: DeviantBaseViewController {
    enum Const {
        static let minColumnSpace: CGFloat = 1.0
        static let minItemSpace: CGFloat = 1.0
        static let minSpace: CGFloat = 1.0
        static let headerHeight: CGFloat = 50.0
    }

    var interactor: TopicListInteractorInterface?
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var defaultCell = UICollectionViewCell()
    private var results: [TopicListResults] = []
    private var offset = 0

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.tryFetchTopicList(with: offset)
    }
}

extension TopicListViewController {
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
        collectionView.register(headNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TopicListHeadView.reuseIdentifier)
    }
}

extension TopicListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.interactor?.showTopic(with: record.name.wrap())
    }
}

extension TopicListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results[section].deviations?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageUICollectionViewCell.reuseIdentifier, for: indexPath) as? ImageUICollectionViewCell,
            let src = results[indexPath.section].deviations?[indexPath.row].preview?.src ,
            let url = URL(string: src) else {
            return UICollectionViewCell()
        }
        cell.image.kf.setImage(with: url, placeholder: nil)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, heightForHeaderIn section: Int) -> CGFloat {
        return Const.headerHeight
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TopicListHeadView.reuseIdentifier, for: indexPath) as? TopicListHeadView {
                let record = results[indexPath.section]
                headView.topicLabel.text = record.name
                headView.tapHandle = {
                    self.interactor?.showTopic(with: record.name.wrap())
                }
                return headView
            }
            return UICollectionReusableView()
        } else {
            return UICollectionReusableView()
        }
    }
}

extension TopicListViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        showError(errorMsg: error.localizedDescription)
    }

    func update(with results: [TopicListResults], nextOffset: Int) {
        if self.offset <= 0 {
            self.results.removeAll()
        }
        self.results.append(contentsOf: results)
        self.offset = nextOffset
        self.collectionView.reloadData()
    }
}
