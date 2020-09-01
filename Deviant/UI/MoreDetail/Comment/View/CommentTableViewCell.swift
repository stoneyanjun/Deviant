//
//  CommentTableViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import UIKit

class CommentTableViewCell: UITableViewCell {
    private enum Const {
        static let imageWidth: CGFloat = 32
        static let leftMargin: CGFloat = 16
        static let topMargin: CGFloat = 8
    }

    private lazy var avatarImageView = UIImageView()

    private lazy var usernameLabel = UILabel.make( color: .white,
                                                   font: UIFont.bodyFont(),
                                                   alignment: .left)
    private lazy var postDateLabel = UILabel.make( color: .lightText,
                                                   font: UIFont.footnoteFont(),
                                                   alignment: .right)
    private lazy var commentLabel = UILabel.make( color: .white,
                                                  font: UIFont.footnoteFont(),
                                                  numOfLines: 0,
                                                  alignment: .left)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeViews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with displayModel: CommentDisplayModel, row: Int) {
        if let avatarUrlString = displayModel.avatarUrlString,
            let url = URL(string: avatarUrlString) {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "bigLoading"))
        } else {
            avatarImageView.image = UIImage(named: "commentAvatar")
        }

        usernameLabel.text = displayModel.username
        postDateLabel.text = displayModel.postedDate
        commentLabel.text = displayModel.comment
    }

    deinit {
        print(#function)
    }
}

extension CommentTableViewCell {
    private func makeViews() {
        contentView.backgroundColor = .defaultBackground
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(postDateLabel)
        addSubview(commentLabel)
    }

    private func applyConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.leftMargin)
            make.top.equalToSuperview().offset(Const.topMargin)
            make.width.equalTo(Const.imageWidth)
            make.height.equalTo(Const.imageWidth)
        }
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Const.leftMargin)
            make.top.equalTo(avatarImageView.snp.top)
            make.trailing.greaterThanOrEqualTo(postDateLabel.snp.leading).offset(Const.leftMargin)
        }
        postDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-Const.leftMargin)
        }
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.equalTo(postDateLabel.snp.trailing)
            make.top.equalTo(usernameLabel.snp.bottom).offset(Const.topMargin)
            make.bottom.equalToSuperview().offset(-Const.topMargin)
        }
    }
}

extension CommentTableViewCell {
    private func setupAccessibility(with displayModel: CommentDisplayModel, row: Int) {
        setAccessibilityIdentifier(.commentTableViewCell, row: row)
        var accessibilityText = displayModel.username + " commented at " + displayModel.postedDate
        accessibilityText += " , " + displayModel.comment
        accessibilityLabel = accessibilityText
    }
}
