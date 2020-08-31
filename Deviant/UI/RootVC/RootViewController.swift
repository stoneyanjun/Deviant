//
//  RootViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import HandyJSON
import Segmentio
import UIKit

class RootViewController: UIViewController {
    private enum Const {
        static let segementHeight: CGFloat = 50
    }

    @IBOutlet private weak var segmentioView: Segmentio!
    @IBOutlet private weak var containView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    private lazy var viewControllers: [UIViewController] = {
        return prepareViewControllers()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.defaultBackground
        title = "DeviantArt"
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

extension RootViewController {
    private func prepareViewControllers() -> [UIViewController] {
        let popularVC = CommonListConfigurator(config:
            CommonListConfiguration(navigationController: navigationController, listType: .popularList)).createViewController()
        let topicListVC = TopicListConfigurator(config:
            TopicListConfiguration(navigationController: navigationController)).createViewController()
        let dailyVC = DailyListConfigurator(config:
            DailyListConfiguration(navigationController: navigationController)).createViewController()
        return [popularVC, topicListVC, dailyVC]
    }

    private func setupScrollView() {
        scrollView.contentSize = CGSize(width: UIScreen.width * CGFloat(viewControllers.count),
                                        height: containView.frame.size.height - Const.segementHeight)

        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(x: CGFloat(index) * UIScreen.width,
                                               y: 0,
                                               width: view.frame.width,
                                               height: (containView.frame.size.height))
            addChild(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize)
            viewController.didMove(toParent: self)
        }
    }

    private func setupSegment() {
        SegmentioBuilder.buildHomeSegmentioView(segmentioView: segmentioView, segmentioStyle: .onlyLabel)

        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0),
                                                  animated: true)
            }
        }

        if segmentioView.selectedSegmentioIndex < 0 {
            segmentioView.selectedSegmentioIndex = 0
        }
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
