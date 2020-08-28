//
//  FavorateViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import CHTCollectionViewWaterfallLayout
import DZNEmptyDataSet
import ESPullToRefresh
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
    private var results: [FavorateDisplayModel] = []
    private var offset = 0
    private var errorDesc: String?

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        interactor?.tryFetchFavorates(offset: offset)
        setupPullToRefresh()
    }
}

extension FavorateViewController {
    func setupPullToRefresh() {
        tableView.es.addPullToRefresh {
            self.offset = 0
            self.errorDesc = nil
            self.interactor?.tryFetchFavorates(offset: self.offset)
        }
        tableView.es.addInfiniteScrolling {
            self.errorDesc = nil
            self.interactor?.tryFetchFavorates(offset: self.offset)
        }
    }

    private func stopES() {
        tableView.es.stopPullToRefresh()
        tableView.es.stopLoadingMore()
    }

    private func updateTableView() {
        if results.isEmpty {
            tableView.emptyDataSetDelegate = self
            tableView.emptyDataSetSource = self
        }
        tableView.reloadData()
    }
}

extension FavorateViewController {
    func makeView() {
        view.backgroundColor = UIColor.defaultBackground
        makeTableView()
    }

    func makeTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = UIColor.defaultBackground
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = Const.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: FavorateTableViewCell.self)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
            let displayModel = results[indexPath.row]
            let viewData = FavorateTableViewCell.ViewData(avatarUrlString: displayModel.avatarUrlString,
                                                          username: displayModel.username,
                                                          favorateDate: displayModel.favorateDate,
                                                          row: indexPath.row)
            cell.update(with: viewData)
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
        stopES()
        updateTableView()
        showError(errorMsg: error.localizedDescription)
    }

    func update(with favorates: [FavorateDisplayModel], nextOffset: Int) {
        stopES()
        if offset <= 0 {
            results = favorates
        } else {
            results.append(contentsOf: favorates)
        }

        results.sort {
            $0.favorateDate < $1.favorateDate
        }

        offset = nextOffset
        updateTableView()
        setLoadingView(with: false)
    }
}

extension FavorateViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchFavorates(offset: offset)
    }
}
