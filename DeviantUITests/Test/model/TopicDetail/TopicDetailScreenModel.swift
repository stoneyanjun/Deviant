//
//  DeviantDetailScreenModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
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
