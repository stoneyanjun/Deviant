//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class ___VARIABLE_sceneName___ViewController: UIViewController
{
    var interactor: ___VARIABLE_sceneName___InteractorInterface?

    private lazy var collectionView: UICollectionView?
    private lazy var defaultCell = UITableViewCell()

    // MARK: View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        makeView()
    }
}

extension ___VARIABLE_sceneName___ViewController {

    func makeView()
    {
        makeCollectionView()
    }

    func makeCollectionView()
    {
    }

}

// MARK: - UICollectionViewDataSource
extension ___VARIABLE_sceneName___ViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "UICollectionViewCell",
            for: indexPath)

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension Segmentio: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
}

extension ___VARIABLE_sceneName___ViewController: ___VARIABLE_sceneName___ViewControllerInterface {

}
