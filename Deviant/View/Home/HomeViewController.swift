//
//  HomeViewController.swift
//  Deviant
//
//  Created by Stone on 2/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testTemp()
    }
}

extension HomeViewController {
    func testTemp()  {
        let config = PopularListConfig()
        let vc = PopularListConfigurator(config: config).createViewController()
        self.present(vc, animated: true)
    }
}
