//
//  MoreDetailContainerVC.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import PanModal
import Segmentio
import UIKit

class MoreDetailContainerVC: DeviantBaseViewController, PanModalPresentable {
    private struct Const {
        static let panModalShortHeight = UIScreen.main.bounds.size.height * 0.9
        static let panModalLongHeight = UIScreen.main.bounds.size.height * 0.1
    }
    @IBOutlet private weak var segmentioView: Segmentio!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    private lazy var viewControllers: [UIViewController] = {
        return self.prepareViewControllers()
    }()

    var deviationid: String = ""
    var focusIndex: Int = 0

    private var offset = 0
    var panScrollable: UIScrollView? {
        return scrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        self.title = "DeviantArt"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScrollView()
        setupSegment()
    }

    deinit {
        print(#file + " " + #function)
    }
}

extension MoreDetailContainerVC {
    private func prepareViewControllers() -> [UIViewController] {
        let metadataVC = MetadataConfigurator(config:
            MetadataConfiguration(navigationController: navigationController,
                                  deviationid: deviationid)).createViewController()
        let commentVC = CommentConfigurator(config:
            CommentConfiguration(navigationController: navigationController,
                                 deviationid: deviationid)).createViewController()
        let moreLikjeVC = MoreLikeConfigurator(config:
            MoreLikeConfiguration(navigationController: navigationController,
                                  deviationid: deviationid)).createViewController()
        let favorateVC = FavorateConfigurator(config:
            FavorateConfiguration(navigationController: navigationController,
                                  deviationid: deviationid)).createViewController()

        return [metadataVC, commentVC, favorateVC, moreLikjeVC]
    }

    private func setupScrollView() {
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
        SegmentioBuilder.buildDetailSegmentioView(segmentioView: segmentioView, segmentioStyle: .onlyLabel)

        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0),
                                                  animated: true)
            }
        }
        segmentioView.selectedSegmentioIndex = focusIndex
    }
}

extension MoreDetailContainerVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
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
