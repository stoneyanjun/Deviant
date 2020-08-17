//
//  FavorateViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import DZNEmptyDataSet
import Kingfisher
import Reusable
import SnapKit
import UIKit

class FavorateViewController: DeviantBaseViewController {
    private struct Const {
        static let estimatedRowHeight = CGFloat(64)
        static let edge = CGFloat(8)
    }

    var interactor: FavorateInteractorInterface?
    private(set) var tableView: UITableView!
    private lazy var defaultCell = UITableViewCell()
    private var results: [FavorateTableViewCell.ViewData] = []

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        interactor?.tryFetchFavorates()
    }
}

extension FavorateViewController {
    func makeView() {
        makeTableView()
    }

    func makeTableView() {
        view.backgroundColor = ColorPalette.defaultBackground
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = ColorPalette.defaultBackground
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = Const.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: FavorateTableViewCell.self)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func updateTableView() {
        if results.isEmpty {
            tableView.emptyDataSetDelegate = self
            tableView.emptyDataSetSource = self
        }
        tableView.reloadData()
    }
}

extension FavorateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension FavorateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
            FavorateTableViewCell.reuseIdentifier,
                                                    for: indexPath) as? FavorateTableViewCell {
            cell.update(with: results[indexPath.row])
            return cell
        } else {
            return defaultCell
        }
    }
}

extension FavorateViewController: FavorateViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
        updateTableView()
    }

    func update(with favorates: [FavorateTableViewCell.ViewData]) {
        setLoadingView(with: false)
        results = favorates
        updateTableView()
    }
}

extension FavorateViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchFavorates()
    }
}
