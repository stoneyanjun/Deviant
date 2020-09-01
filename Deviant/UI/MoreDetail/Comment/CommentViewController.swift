//
//  CommentViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import DZNEmptyDataSet
import ESPullToRefresh
import Kingfisher
import SnapKit
import UIKit

class CommentViewController: DeviantBaseViewController {
    private struct Const {
        static let estimatedRowHeight = CGFloat(280)
        static let edge = CGFloat(8)
    }

    var interactor: CommentInteractorInterface?
    private(set) var commentTableView: UITableView!
    private lazy var defaultCell = UITableViewCell()
    private var results: [CommentDisplayModel] = []
    private var offset = 0
    private var errorDesc: String?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        interactor?.tryFetchComments(offset: offset)
    }

    deinit {
        print(#file + " " + #function)
    }
}

extension CommentViewController {
    func setupPullToRefresh() {
        commentTableView.es.addPullToRefresh {
            [weak self] in
            self?.offset = 0
            self?.errorDesc = nil
            self?.interactor?.tryFetchComments(offset: self?.offset ?? 0)
        }
        commentTableView.es.addInfiniteScrolling {
            [weak self] in
            self?.errorDesc = nil
            self?.interactor?.tryFetchComments(offset: self?.offset ?? 0)
        }
    }

    private func stopES() {
        commentTableView.es.stopPullToRefresh()
        commentTableView.es.stopLoadingMore()
    }

    private func updateTableView() {
        if results.isEmpty {
            commentTableView.emptyDataSetDelegate = self
            commentTableView.emptyDataSetSource = self
        }
        commentTableView.reloadData()
    }
}

extension CommentViewController {
    func makeView() {
        view.backgroundColor = UIColor.defaultBackground
        makeTableView()
        setupPullToRefresh()
    }

    func makeTableView() {
        commentTableView = UITableView(frame: .zero, style: .plain)
        commentTableView.backgroundColor = UIColor.defaultBackground
        view.addSubview(commentTableView)
        commentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        commentTableView.delegate = self
        commentTableView.dataSource = self

        commentTableView.separatorStyle = .none
        commentTableView.estimatedRowHeight = Const.estimatedRowHeight
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.register(cellType: CommentTableViewCell.self)
    }
}

extension CommentViewController: UITableViewDelegate {
    func commentTableView(_ commentTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ commentTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ commentTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = commentTableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? CommentTableViewCell {
            cell.update(with: results[indexPath.row],
                        row: indexPath.row)
            return cell
        } else {
            return defaultCell
        }
    }
}

extension CommentViewController: CommentViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        stopES()
        updateTableView()
        showError(errorMsg: error.localizedDescription)
    }

    func update(with results: [CommentDisplayModel], nextOffset: Int) {
        stopES()
        offset = nextOffset
        self.results = results
        updateTableView()
        setLoadingView(with: false)
    }
}

extension CommentViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchComments(offset: offset)
    }
}
