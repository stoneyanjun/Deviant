//
//  DailyListViewController.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import DZNEmptyDataSet
import Kingfisher
import SnapKit
import UIKit

class DailyListViewController: DeviantBaseViewController {
    private struct Const {
        static let estimatedRowHeight = CGFloat(280)
        static let edge = CGFloat(8)
    }

    var interactor: DailyListInteractorInterface?
    private(set) var dailyTableView: UITableView!
    private lazy var defaultCell = UITableViewCell()
    private var results: [DeviantDetailDisplayModel] = []

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        interactor?.tryFetchDaily(with: "")

        dailyTableView.es.addPullToRefresh {
            [weak self] in
            self?.interactor?.tryFetchDaily(with: "")
        }
    }

    deinit {
        print(#file + " " + #function)
    }
}

extension DailyListViewController {
    private func stopES() {
        dailyTableView.es.stopPullToRefresh()
        dailyTableView.es.stopLoadingMore()
    }

    private func updateTableView() {
        if results.isEmpty {
            dailyTableView.emptyDataSetDelegate = self
            dailyTableView.emptyDataSetSource = self
        }
        dailyTableView.reloadData()
    }
}

extension DailyListViewController {
    func makeView() {
        view.backgroundColor = UIColor.defaultBackground

        dailyTableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(dailyTableView)
        dailyTableView.delegate = self
        dailyTableView.dataSource = self
        dailyTableView.backgroundColor = UIColor.defaultBackground

        dailyTableView.separatorStyle = .none
        dailyTableView.estimatedRowHeight = Const.estimatedRowHeight
        dailyTableView.rowHeight = UITableView.automaticDimension
        dailyTableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseIdentifier)

        dailyTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DailyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = results[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseIdentifier,
                                                    for: indexPath) as? DailyTableViewCell {
            let viewData = DailyTableViewCell.ViewData(detail: detail,
                                                       identifier: .dailyTableViewCell,
                                                       row: indexPath.row)
            cell.update(with: viewData)
            return cell
        } else {
            return defaultCell
        }
    }
}

extension DailyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.showDeviation(with: results[indexPath.row])
    }
}

extension DailyListViewController: DailyListViewControllerInterface {
    func setLoadingView(with status: Bool) {
        stopES()
        setHUD(with: status)
    }
    func showError(with error: Error) {
        stopES()
        showError(errorMsg: error.localizedDescription)
        updateTableView()
    }

    func update(with results: [DeviantDetailDisplayModel]) {
        stopES()
        self.results = results
        updateTableView()
        setLoadingView(with: false)
    }
}

extension DailyListViewController: DZNEmptyDataSetDelegate {
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        interactor?.tryFetchDaily(with: "")
    }
}
