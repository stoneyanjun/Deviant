//
//  ViewController.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        TokenManager.shared.fetchToken { result in
            switch result {
            case .success(let tokenBase):
                print(#function + " accessToken: \(tokenBase.accessToken)")
                self.title = tokenBase.accessToken
            case .failure(let error):
                print(#function +  "\(error.deviantError.localizedDescription)")
            }
        }
    }
}
