//
//  TopicListHeadView.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

class TopicListHeadView: UICollectionReusableView, Reusable {
    private enum Const {
        static let margin = 16
    }

    typealias TapHandle = (() -> Void)
    private var tapHandle: TapHandle?
    private lazy var topicButton = UIButton()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topicButton)
        topicButton.contentHorizontalAlignment = .left
        topicButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Const.margin)
            make.trailing.equalToSuperview().offset(-Const.margin)
        }

        topicButton.addTarget(self, action: #selector(topicAction(_:)), for: .touchUpInside)
    }

    @objc
    private func topicAction(_ sender: Any) {
        tapHandle?()
    }
}

extension TopicListHeadView {
    struct ViewData {
        var title: String
        var row: Int
        var identifier: AccessibilityIdentifier
        var tapHandle: TapHandle?
    }

    func update(with viewData: ViewData) {
        topicButton.setTitleForAllStates(viewData.title)
        self.tapHandle = viewData.tapHandle
        setAccessibilityIdentifier(viewData.identifier, row: viewData.row)
        accessibilityTraits = .header
        print(accessibilityIdentifier)
    }
}
