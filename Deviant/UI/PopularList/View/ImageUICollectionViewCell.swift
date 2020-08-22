//
//  ImageUICollectionViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

class ImageUICollectionViewCell: UICollectionViewCell, Reusable {
    private (set) var imageView = UIImageView()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
