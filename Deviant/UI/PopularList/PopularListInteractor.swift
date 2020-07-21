//
//  PopularListInteractor.swift
//  Deviant
//
//  Created by Stone on 21/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class PopularListInteractor
{
    var presenter: PopularListPresenterInterface?
    private(set) var config: PopularListConfiguration

    init(config: PopularListConfiguration) {
        self.config = config
    }
}

extension PopularListInteractor: PopularListInteractorInterface {

}
