//
//  FavorateTableViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

class FavorateTableViewCell: UITableViewCell {
    private enum Const {
        static let margin: CGFloat = 12
        static let imageWith: CGFloat = 32
    }

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var nameLabel = UILabel.make(color: .white,
                                              font: UIFont.headlineFont(),
                                              alignment: .left)

    private lazy var dateLabel = UILabel.make(color: .white,
                                              font: UIFont.footnoteFont(),
                                              alignment: .right)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeViews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with displayModel: FavorateDisplayModel, row: Int) {
        if let url = URL(string: displayModel.avatarUrlString.wrap()) {
            avatarImageView.kf.setImage(with: url,
                                        placeholder: UIImage(named: "bigLoading"))
        } else {
            avatarImageView.image = UIImage(named: "commentAvatar")
        }
        nameLabel.text = displayModel.username
        dateLabel.text = displayModel.favorateDate

        setupAccessibility(with: displayModel, row: row)
    }

    deinit {
        print(#function)
    }
}

extension FavorateTableViewCell {
    private func makeViews() {
        contentView.backgroundColor = UIColor.defaultBackground
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
            make.trailing.equalToSuperview().offset(-Const.margin)
        }
    }
}

extension FavorateTableViewCell {
    private func setupAccessibility(with displayModel: FavorateDisplayModel, row: Int) {
        accessibilityElements = []
        setAccessibilityIdentifier(.favorateTableViewCell, row: row)
        accessibilityLabel = "\(displayModel.username) favorated at \(displayModel.favorateDate)"
    }
}
