//
//  PopularListViewController.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit


class PopularListViewController: UIViewController
{
    var interactor: PopularListInteractorInterface?

    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        makeView()
    }
}

extension PopularListViewController {

    func makeView()
    {
    }
}

extension PopularListViewController: PopularListViewControllerInterface {

}
