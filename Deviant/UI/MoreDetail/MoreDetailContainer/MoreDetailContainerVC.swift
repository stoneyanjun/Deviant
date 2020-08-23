//
//  MoreDetailContainerVC.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import PanModal
import Segmentio
import SnapKit
import UIKit

class MoreDetailContainerVC: DeviantBaseViewController, PanModalPresentable {
    private struct Const {
        static let segmentioHeight: CGFloat = 50
        static let panModalShortHeight = UIScreen.main.bounds.size.height * 0.9
        static let panModalLongHeight = UIScreen.main.bounds.size.height * 0.1
    }

    private var moreSegmentioView: Segmentio?
    private var moreContainView: UIView?
    private var moreScrollView: UIScrollView?
//    @IBOutlet private weak var segmentioView: Segmentio!
//    @IBOutlet private weak var containView: UIView!
//    @IBOutlet private weak var scrollView: UIScrollView!
    
    private lazy var viewControllers: [UIViewController] = {
        return self.prepareViewControllers()
    }()

    var deviantDetail: DeviantDetailBase?
    var focusIndex: Int = 0
    private var offset = 0
    var panScrollable: UIScrollView? {
        return moreScrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        self.title = "DeviantArt"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeViews()
        setupScrollView()
        setupSegment()
    }
}


extension MoreDetailContainerVC {
    private func makeViews() {
        guard moreSegmentioView == nil else {
            return
        }

        let segmentioViewRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Const.segmentioHeight)
        let segmentioView = Segmentio(frame: segmentioViewRect)
        view.addSubview(segmentioView)
        moreSegmentioView = segmentioView

        let containerView = UIView()
        view.addSubview(containerView)
        moreContainView = containerView

        let scrollView = UIScrollView()
        moreContainView?.addSubview(scrollView)
        moreScrollView = scrollView

        applyConstraints()
    }

    private func applyConstraints() {

        guard let segmentioView = moreSegmentioView,
        let containView = moreContainView,
        let scrollView = moreScrollView else {
            return
        }

        segmentioView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(Const.segmentioHeight)
        })

        containView.snp.makeConstraints({ make in
            make.top.equalTo(segmentioView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })

        scrollView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }
}
extension MoreDetailContainerVC {
    private func prepareViewControllers() -> [UIViewController] {
        let metadataVC = MetadataConfigurator(config:
            MetadataConfiguration(navigationController: navigationController,
                                  deviantDetail: deviantDetail)).createViewController()
        let commentVC = CommentConfigurator(config:
            CommentConfiguration(navigationController: navigationController,
                                 deviantDetail: deviantDetail)).createViewController()
        let moreLikjeVC = MoreLikeConfigurator(config:
            MoreLikeConfiguration(navigationController: navigationController,
                                  deviantDetail: deviantDetail)).createViewController()
        let favorateVC = FavorateConfigurator(config:
            FavorateConfiguration(navigationController: navigationController,
                                  deviantDetail: deviantDetail)).createViewController()

        return [metadataVC, commentVC, favorateVC, moreLikjeVC]
    }

    private func setupScrollView() {
        guard let scrollView = moreScrollView,
        let containView = moreContainView else {
            return
        }
        scrollView.contentSize = CGSize(width: UIScreen.width * CGFloat(viewControllers.count),
                                        height: containView.frame.size.height)

        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(x: CGFloat(index) * UIScreen.width,
                                               y: 0,
                                               width: view.frame.width,
                                               height: view.frame.height)
            addChild(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize)
            viewController.didMove(toParent: self)
        }
    }

    private func setupSegment() {
        guard let segmentioView = moreSegmentioView else {
            return
        }

        SegmentioBuilder.buildDetailSegmentioView(segmentioView: segmentioView, segmentioStyle: .onlyLabel)

        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollWidth = self?.moreScrollView?.frame.width {
                let contentOffsetX = scrollWidth * CGFloat(segmentIndex)
                self?.moreScrollView?.setContentOffset(CGPoint(x: contentOffsetX, y: 0),
                                                       animated: true)
            }
        }
        segmentioView.selectedSegmentioIndex = focusIndex
    }
}

extension MoreDetailContainerVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let segmentioView = moreSegmentioView else {
            return
        }
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}

extension MoreDetailContainerVC {
    var shortFormHeight: PanModalHeight {
        return .contentHeight(Const.panModalShortHeight)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(Const.panModalLongHeight)
    }
}
