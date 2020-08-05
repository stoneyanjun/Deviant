//
//  DailyListViewController.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import Kingfisher
import Reusable
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
    private var datas: [DeviantDetailBase] = []

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.tryFetchDaily(with: "")
    }
}

extension DailyListViewController {
    func makeView() {
        makeTableView()
    }

    func makeTableView() {
        dailyTableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(dailyTableView)
        dailyTableView.delegate = self
        dailyTableView.dataSource = self

        dailyTableView.separatorStyle = .none
        dailyTableView.estimatedRowHeight = Const.estimatedRowHeight
        dailyTableView.rowHeight = UITableView.automaticDimension
        dailyTableView.register(DailyTableViewCell.createNib(), forCellReuseIdentifier: DailyTableViewCell.reuseIdentifier)

        dailyTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DailyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseIdentifier, for: indexPath) as? DailyTableViewCell {
            cell.update(with: datas[indexPath.row])
            return cell
        } else {
            return defaultCell
        }
    }
}

extension DailyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.showDeviation(with: datas[indexPath.row])
    }
}

extension DailyListViewController: DailyListViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
    }

    func update(with results: [DeviantDetailBase]) {
        datas = results
        dailyTableView.reloadData()
    }
}
