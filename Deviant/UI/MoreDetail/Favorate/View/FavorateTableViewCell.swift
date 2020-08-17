//
//  FavorateTableViewCell.swift
//  Deviant
//
//  Created by Stone on 17/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Kingfisher
import Reusable
import SnapKit
import UIKit

class FavorateTableViewCell: UITableViewCell, Reusable {
    private enum Const {
        static let margin: CGFloat = 12
        static let imageWith: CGFloat = 32
        static let rightMargin: CGFloat = 8
    }

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ColorPalette.defaultBackground
        label.textColor = .white
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ColorPalette.defaultBackground
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeViews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with data: ViewData) {
        if let url = URL(string: data.avatarUrlString.wrap()) {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "loading"))
        } else {
            avatarImageView.image = UIImage(named: "AvatorWhite")
        }
        nameLabel.text = data.username
        dateLabel.text = data.favorateDate
    }

    deinit {
        print(#function)
    }
}

extension FavorateTableViewCell {
    private func makeViews() {
        contentView.backgroundColor = ColorPalette.defaultBackground
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
    }

    private func applyConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.margin)
            make.width.equalTo(Const.imageWith)
            make.height.equalTo(Const.imageWith)
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Const.margin)
            make.top.equalToSuperview().offset(Const.margin)
            make.bottom.equalToSuperview().offset(-Const.margin)
        }
        dateLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(Const.margin)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-Const.rightMargin)
        }
    }
}

extension FavorateTableViewCell {
    struct ViewData {
        var avatarUrlString: String?
        var username: String
        var favorateDate: String
    }
}
