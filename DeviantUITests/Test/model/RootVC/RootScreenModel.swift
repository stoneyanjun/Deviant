//
//  RootScreenModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

final class RootSceenModel: BaseScreenModel {
    private func showPage(index: Int) -> RootSceenModel {
        let item = cell(at: index)
        item?.tap()
        return self
    }

    func showPopularPage() -> RootSceenModel {
        return showPage(index: 0)
    }
    func showTopicListPage() -> RootSceenModel {
        return showPage(index: 1)
    }

    func showDailyPage() -> RootSceenModel {
        return showPage(index: 2)
    }
}
