//
//  PopularListVCInteractor.swift
//  Deviant
//
//  Created by Stone on 16/7/2020.
//  Copyright (c) 2020 JustNow. All rights reserved.
//

import UIKit

class PopularListVCInteractor
{
    var presenter: PopularListVCPresenterInterface?
    private(set) var config: PopularListVCConfiguration

    init(config: PopularListVCConfiguration) {
        self.config = config
    }
}

extension PopularListVCInteractor: PopularListVCInteractorInterface {

}
