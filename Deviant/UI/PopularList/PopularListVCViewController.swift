//
//  PopularListVCViewController.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit


class PopularListVCViewController: DeviantBaseVC
{
    var interactor: PopularListVCInteractorInterface?

    private(set) var tableView: UITableView!
    private lazy var defaultCell = UITableViewCell()

    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        makeView()
    }
}

extension PopularListVCViewController {

    func makeView()
    {
        makeTableView()
    }

    func makeTableView()
    {
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension PopularListVCViewController: UITableViewDataSource {
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

extension PopularListVCViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension PopularListVCViewController: PopularListVCViewControllerInterface {

}
