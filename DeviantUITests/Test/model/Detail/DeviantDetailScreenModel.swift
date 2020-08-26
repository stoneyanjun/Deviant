//
//  DeviantDetailScreenModel.swift
//  DeviantUITests
//
//  Created by Stone on 26/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import UIKit

class DeviantDetailScreenModel: BaseScreenModel {
    func showMoreInfoPage() -> DeviantDetailScreenModel {
        app.buttons["more_info_button"]
            .firstMatch
            .forceTapElement()
        return self
    }
    /*
    func showCommentPage() -> DeviantDetailScreenModel {
        app.buttons["comment_button"]
            .firstMatch
            .forceTapElement()
        return self
    }

    func showFavoratePage() -> DeviantDetailScreenModel {
        app.buttons["favorate_button"]
            .firstMatch
            .forceTapElement()
        return self
    }

    func showMoreLikePage() -> DeviantDetailScreenModel {
        app.buttons["more_like_button"]
            .firstMatch
            .forceTapElement()
        return self
    }*/

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
