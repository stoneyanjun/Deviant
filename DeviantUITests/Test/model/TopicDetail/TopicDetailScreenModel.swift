//
//  DeviantDetailScreenModel.swift
//  DeviantUITests
//
//  Created by Stone on 26/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

class TopicDetailScreenModel: BaseScreenModel {
    func showDetail() -> TopicDetailScreenModel {
        return showCellItem(index: 0)
    }

    private func showCellItem(index: Int) -> TopicDetailScreenModel {
        let item = cell(at: index)
        item?.tap()
        return self
    }
}
