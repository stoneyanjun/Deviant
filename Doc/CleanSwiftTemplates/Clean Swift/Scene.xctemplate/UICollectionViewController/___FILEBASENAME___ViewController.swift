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

    private(set) var collectionView: UICollectionView!
    private lazy var defaultCell = UICollectionViewCell()

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
        makeUICollectionView()
    }

    func makeUICollectionView()
    {
    }

}

extension ___VARIABLE_sceneName___ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return defaultCell
    }
}

extension ___VARIABLE_sceneName___ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension ___VARIABLE_sceneName___ViewController: ___VARIABLE_sceneName___ViewControllerInterface{
}
