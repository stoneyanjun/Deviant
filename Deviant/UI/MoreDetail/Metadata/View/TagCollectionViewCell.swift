//
//  TagCollectionViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

class TagCollectionViewCell: UICollectionViewCell, Reusable {
    private enum Const {
        static let margin: CGFloat = 8
    }

    private lazy var tagLabel = UILabel.make(color: .white,
                                             font: UIFont.footnoteFont(),
                                             alignment: .center)

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tagLabel)

        tagLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.margin)
            make.trailing.equalToSuperview().offset(Const.margin)
            make.top.equalToSuperview().offset(Const.margin)
            make.bottom.equalToSuperview().offset(Const.margin)
        }
    }

    func update(with tagName: String) {
        tagLabel.text = tagName
    }

    deinit {
        print(#function)
    }
}

extension TagCollectionViewCell {
    func setupAccessibility(row: Int) {
        setAccessibilityIdentifier(.tagCollectionViewCell, row: row)
    }
}
