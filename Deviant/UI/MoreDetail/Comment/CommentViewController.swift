//
//  CommentViewController.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import Kingfisher
import Reusable
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
    private var comments: [CommentTableViewCell.ViewData] = []

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.tryFetchComments()
    }
}

extension CommentViewController {
    func makeView() {
        makeTableView()
    }

    func makeTableView() {
        commentTableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(commentTableView)
        commentTableView.delegate = self
        commentTableView.dataSource = self

        commentTableView.separatorStyle = .none
        commentTableView.estimatedRowHeight = Const.estimatedRowHeight
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.register(CommentTableViewCell.createNib(), forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)

        commentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CommentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension CommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as? CommentTableViewCell {
            cell.update(with: comments[indexPath.row])
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
        showError(errorMsg: error.localizedDescription)
    }

    func update(with comments: [CommentTableViewCell.ViewData]) {
//        datas = results
        self.comments = comments
        commentTableView.reloadData()
    }
}
