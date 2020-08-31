//
//  CommonCollectionViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import PKHUD
import Reusable
import SnapKit
import UIKit

class CommonCollectionViewCell: UICollectionViewCell, Reusable {
    private enum Const {
        static let fakeImageViewWidth: CGFloat = 32
    }

    private var srcImageView = UIImageView()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(srcImageView)
        srcImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        srcImageView.accessibilityElementsHidden = true
    }

    deinit {
        print(#file + " " + #function)
    }
}

extension CommonCollectionViewCell {
    func update(with viewData: ViewData) {
        srcImageView.kf.setImage(with: viewData.url,placeholder: UIImage(named: "bigLoading"))
        setupAccessibility(with: viewData)
    }

    private func setupAccessibility(with viewData: ViewData) {
        setAccessibilityIdentifier(viewData.identifier, row: viewData.row)

        guard var title = viewData.title,
            !title.isEmpty else {
            return
        }
        if let username = viewData.username, !username.isEmpty {
            title += " by " + username
        }
        accessibilityLabel = title
    }
}

extension CommonCollectionViewCell {
    struct ViewData {
        var url: URL
        var title: String?
        var username: String?
        var identifier: AccessibilityIdentifier
        var row: Int
    }
}
