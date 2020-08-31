//
//  DeviantDetailScreenModel.swift
//  DeviantUITests
//
//  Copyright © 2020 Stone. All rights reserved.
//

import UIKit

class DeviantDetailScreenModel: BaseScreenModel {
    func showMoreInfoPage() -> DeviantDetailScreenModel {
        app.buttons["more_info_button"]
            .firstMatch
            .forceTap()
        return self
    }
    
    private func showPage(index: Int) -> DeviantDetailScreenModel {
        let item = cell(at: index)
        item?.tap()
        return self
    }

    func showInternalCommentPage() -> DeviantDetailScreenModel {
        return showPage(index: 1)
    }
    func showInternalFavoratePage() -> DeviantDetailScreenModel {
        return showPage(index: 2)
    }

    func showInternalMoreLikePage() -> DeviantDetailScreenModel {
        return showPage(index: 3)
    }
}
