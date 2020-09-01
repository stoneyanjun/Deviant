//
//  TagCollectionViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import SnapKit
import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    private enum Const {
        static let upMargin: CGFloat = 8
        static let leadingMargin: CGFloat = 6
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
            make.leading.equalToSuperview().offset(Const.leadingMargin)
            make.trailing.equalToSuperview().offset(-Const.leadingMargin)
            make.top.equalToSuperview().offset(Const.upMargin)
            make.bottom.equalToSuperview().offset(-Const.upMargin)
        }
        contentView.backgroundColor = UIColor.tagCellBackground
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
