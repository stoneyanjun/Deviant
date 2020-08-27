//
//  ImageUICollectionViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import PKHUD
import Reusable
import SnapKit
import UIKit

class ImageUICollectionViewCell: UICollectionViewCell, Reusable {
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
    }

    deinit {
        print(#function)
    }
}

extension ImageUICollectionViewCell {
    func update(with url: URL) {
        srcImageView.kf.setImage(with: url,placeholder: UIImage(named: "bigLoading"))
    }

    func setupAccessibility(with identifier: AccessibilityIdentifier, row: Int) {
        setAccessibilityIdentifier(identifier, row: row)
        print(accessibilityIdentifier)
    }
}
