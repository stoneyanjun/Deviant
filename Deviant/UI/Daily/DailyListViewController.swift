//
//  DailyListViewController.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import Reusable
import UIKit
import Kingfisher

class DailyListViewController: DeviantBaseViewController {
    var interactor: DailyListInteractorInterface?

    private(set) var tableView: UITableView!
    private lazy var defaultCell = UITableViewCell()

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        interactor?.tryFetchDaily(with: "")
    }
}

extension DailyListViewController {
    func makeView() {
        makeTableView()
    }

    func makeTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension DailyListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return defaultCell
    }
}

extension DailyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension DailyListViewController: DailyListViewControllerInterface {
    func setLoadingView(with status: Bool) {
        setHUD(with: status)
    }
    func showError(with error: Error) {
        showError(errorMsg: error.localizedDescription)
    }
}
