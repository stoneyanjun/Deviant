//
//  RootScreenModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Foundation
import XCTest

final class RootSceenModel: UIScreenModel {
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

    func openFirstPopularItem() -> RootSceenModel {
        app.collectionViews.children(matching: .cell)["popular_list_collection_cell_0"].firstMatch.tap()
        return self
    }

    func openFirstTopic() -> RootSceenModel {
        app.collectionViews.children(matching: .any)["topic_list_head_view_0"].firstMatch.forceTap()
        return self
    }

    func openFirstDaily() -> RootSceenModel {
        app.tables.children(matching: .cell)["daily_table_view_cell_0"].firstMatch.tap()
        return self
    }
}
