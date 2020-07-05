//
//  PopularListInteractor.swift
//  Deviant
//
//  Created by stone on 2020/7/5.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class PopularListInteractor
{
    var presenter: PopularListPresenterInterface?
    private(set) var config: PopularListConfig

    init(config: PopularListConfig) {
        self.config = config
    }
}

extension PopularListInteractor: PopularListInteractorInterface {

}
