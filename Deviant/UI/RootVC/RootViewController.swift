//
//  RootViewController.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import HandyJSON
import Segmentio
import UIKit

class RootViewController: UIViewController {
    @IBOutlet private weak var segmentioView: Segmentio!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    private lazy var viewControllers: [UIViewController] = {
        return self.prepareViewControllers()
    }()
    private var offset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DeviantArt"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScrollView()
        setupSegment()
    }
}

extension RootViewController {
    private func prepareViewControllers() -> [UIViewController] {
        let popularVC = PopularListConfigurator(config: PopularListConfiguration()).createViewController()
        let topicListVC = TopicListConfigurator(config: TopicListConfiguration()).createViewController()
        let dailyVC = DailyListConfigurator(config: DailyListConfiguration()).createViewController()
        return [popularVC, topicListVC, dailyVC]
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
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentioView, segmentioStyle: .onlyLabel)

        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0),
                                                  animated: true)
            }
        }

        segmentioView.selectedSegmentioIndex = 1
    }
}

extension RootViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}
