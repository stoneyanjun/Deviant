//
//  PopularListViewController.swift
//  Deviant
//
//  Created by stone on 2020/7/5.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit


class PopularListViewController: DeviantBaseViewController
{
    var interactor: PopularListInteractorInterface?

    private(set) var collectionView: UICollectionView!
    private lazy var defaultCell = UICollectionViewCell()

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
        makeUICollectionView()
    }

    func makeUICollectionView()
    {
    }

}

extension PopularListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return defaultCell
    }
}

extension PopularListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension PopularListViewController: PopularListViewControllerInterface{
}
